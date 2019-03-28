import 'package:kitten/src/core/model/cat.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteBloc {

  final _favourites = BehaviorSubject<List<Cat>>();

  Observable<List<Cat>> get favourites => _favourites.stream;
}