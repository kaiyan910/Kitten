import 'package:kitten/src/core/network/model/cat.dart';
import 'package:kitten/src/core/network/remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {

  final _remoteProvider = RemoteProvider();

  final _searchResult = BehaviorSubject<List<Cat>>();

  Observable<List<Cat>> get searchResult => _searchResult.stream;

  SearchBloc() {

    print("[DEBUG] SearchBloc costructor");
    search();
  }

  search() async {

    final cats = await _remoteProvider.search(21, 1, "image/png");
    _searchResult.sink.add(cats);
  }

  save(String id) async { }

  dispose() {

    _searchResult.close();
  }
}