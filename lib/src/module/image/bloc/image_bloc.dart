import 'package:kitten/src/core/database/local_repository.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageBloc {
  final _localRepository = localRepository;

  final _imageState = BehaviorSubject<ImageState>();

  Observable<ImageState> get imageState => _imageState.stream;

  ImageBloc() {
    _imageState.sink.add(ImageState.initial());
  }

  download(String url) async {
    try {
      print("[DEBUG] share=$url");
      // get last state
      final ImageState currentState = await imageState.first;
      print("[DEBUG] $currentState");
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
    }
  }

  share(String url, String message) async {
    print("[DEBUG] share=$url");
    final ImageState currentState = await imageState.first;
    print("[DEBUG] $currentState");

    if (currentState.downloading) return;

    if (currentState.imagePath.isNotEmpty) {
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

  checkFavourite(String id) async {
    final ImageState currentState = await imageState.first;
    final result = await _localRepository.hasFavourite(id);
    _imageState.sink.add(currentState.copyWith(
      favourite: result,
      showSnackBar: false,
    ));
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
      showSnackBar: favourite,
    ));
  }

  dispose() async {
    await _imageState.drain();
    _imageState.close();
  }
}

class ImageState {
  final bool favourite;
  final bool showSnackBar;
  final bool downloading;
  final String imagePath;

  ImageState(
      {this.favourite = false,
      this.showSnackBar = false,
      this.downloading = false,
      this.imagePath = ""});

  ImageState.initial()
      : favourite = false,
        showSnackBar = false,
        downloading = false,
        imagePath = "";

  copyWith(
          {bool favourite,
          bool showSnackBar,
          bool downloading,
          String imagePath}) =>
      ImageState(
        favourite: favourite ?? this.favourite,
        showSnackBar: showSnackBar ?? this.showSnackBar,
        downloading: downloading ?? this.downloading,
        imagePath: imagePath ?? this.imagePath,
      );

  @override
  String toString() {
    return 'ImageState{favourite: $favourite, showSnackBar: $showSnackBar, downloading: $downloading, imagePath: $imagePath}';
  }
}
