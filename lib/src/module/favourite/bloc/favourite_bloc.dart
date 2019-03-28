import 'package:kitten/src/common/mixins/status_bar_handler.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/database/local_repository.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteBloc with StatusBarHandler {

  final _localRepository = localRepository;
  final _favourites = BehaviorSubject<List<Cat>>();

  Observable<List<Cat>> get favourites => _favourites.stream;

  fetch() async {

    List<Cat> cats = await _localRepository.fetchFavourites();
    _favourites.sink.add(cats);
  }

  dispose() async {

    await _favourites.drain();
    _favourites.close();
  }
}
