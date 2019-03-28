import 'package:kitten/src/core/database/database_provider.dart';
import 'package:kitten/src/core/database/local_repository.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:rxdart/rxdart.dart';

class ImageBloc {
  final _localRepository = localRepository;

  final _favouriteFetcher = PublishSubject<bool>();
  final _favourite = BehaviorSubject<bool>();

  Observable<bool> get favourite => _favourite.stream;

  Function(bool) get updateFavourite => _favouriteFetcher.sink.add;

  ImageBloc() {
    _favouriteFetcher.stream.pipe(_favourite);
  }

  checkFavourite(String id) async {
    final result = await _localRepository.hasFavourite(id);
    _favouriteFetcher.sink.add(result);
  }

  changeFavouriteStatus(Cat cat, bool favourite) async {

    int res = -1;

    if (favourite) {
      res = await _localRepository.insertFavourite(cat.toMap());
    } else {
      res = await _localRepository.deleteFavourite(cat.id);
    }

    print("[DEBUG] res=$res");

    _favouriteFetcher.sink.add(favourite);
  }

  dispose() async {
    _favouriteFetcher.close();
    await _favourite.drain();
    _favourite.close();
  }
}
