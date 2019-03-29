import 'package:kitten/src/common/mixins/status_bar_handler.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/network/remote_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc with StatusBarHandler {
  final _remoteProvider = remoteRepository;
  final _searchResult = BehaviorSubject<SearchScreenState>();

  Observable<SearchScreenState> get searchResult => _searchResult.stream;

  SearchBloc() {
    search();
  }

  search() async {
    final cats = await _remoteProvider.search(21, 1, "image/png");
    _searchResult.sink.add(SearchScreenState(true, cats));
  }

  dispose() async {
    await _searchResult.drain();
    _searchResult.close();
  }
}

class SearchScreenState {
  final bool init;
  final List<Cat> results;

  SearchScreenState(this.init, this.results);

  SearchScreenState.initial()
      : init = false,
        results = List<Cat>();
}
