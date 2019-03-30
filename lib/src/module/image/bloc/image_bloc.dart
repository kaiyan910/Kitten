import 'package:kitten/src/common/mixins/status_bar_handler.dart';
import 'package:kitten/src/core/bloc/bloc.dart';
import 'package:kitten/src/core/database/local_repository.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageBloc extends BaseBloc with StatusBarHandler {
  final LocalRepository _localRepository;
  final Cat _cat;
  final _imageState = BehaviorSubject<ImageState>();

  Observable<ImageState> get imageState => _imageState.stream;

  ImageBloc(this._localRepository, this._cat) {
    _init(_cat.id);
  }

  @override
  dispose() async {
    await _imageState.drain();
    _imageState.close();
  }

  download(String url) async {
    // get last state
    final ImageState currentState = await imageState.first;

    try {
      // ignore it, if it is downloading
      if (currentState.downloading) return;
      _imageState.sink.add(currentState.copyWith(downloading: true));

      var imageId = await ImageDownloader.downloadImage(url);
      var path = await ImageDownloader.findPath(imageId);

      _imageState.sink.add(currentState.copyWith(
        showSnackBar: true,
        downloading: false,
        imagePath: path,
      ));
    } on Exception catch (error) {
      print(error);

      _imageState.sink.add(currentState.copyWith(
          showSnackBar: true, downloading: false, hasError: true));
    }
  }

  share(String url, String message) async {
    final ImageState currentState = await imageState.first;

    if (currentState.downloading) {
      return;
    } else if (currentState.imagePath.isNotEmpty) {
      Share.image(
        path: currentState.imagePath,
        text: message,
      ).share();
    } else {
      _imageState.sink.add(currentState.copyWith(downloading: true));

      var imageId = await ImageDownloader.downloadImage(url);
      var path = await ImageDownloader.findPath(imageId);

      _imageState.sink.add(currentState.copyWith(
        showSnackBar: true,
        downloading: false,
        imagePath: path,
      ));

      Share.image(
        path: path,
        text: message,
      ).share();
    }
  }

  changeFavouriteStatus(Cat cat, bool favourite) async {
    final ImageState currentState = await imageState.first;
    if (favourite) {
      await _localRepository.insertFavourite(cat.toMap());
    } else {
      await _localRepository.deleteFavourite(cat.id);
    }
    _imageState.sink.add(currentState.copyWith(
      favourite: favourite,
      showSnackBar: false,
    ));
  }

  _init(String id) async {
    final result = await _localRepository.hasFavourite(id);
    _imageState.sink.add(ImageState(
      favourite: result,
    ));
  }
}

class ImageState {
  final bool favourite;
  final bool showSnackBar;
  final bool hasError;
  final bool downloading;
  final String imagePath;

  ImageState({
    this.favourite = false,
    this.showSnackBar = false,
    this.hasError = false,
    this.downloading = false,
    this.imagePath = "",
  });

  ImageState.initial()
      : favourite = false,
        showSnackBar = false,
        hasError = false,
        downloading = false,
        imagePath = "";

  copyWith(
          {bool favourite,
          bool showSnackBar,
          bool hasError,
          bool downloading,
          String imagePath}) =>
      ImageState(
        favourite: favourite ?? this.favourite,
        showSnackBar: showSnackBar ?? this.showSnackBar,
        hasError: hasError ?? this.hasError,
        downloading: downloading ?? this.downloading,
        imagePath: imagePath ?? this.imagePath,
      );

  @override
  String toString() {
    return 'ImageState{favourite: $favourite, showSnackBar: $showSnackBar, hasError: $hasError, downloading: $downloading, imagePath: $imagePath}';
  }
}
