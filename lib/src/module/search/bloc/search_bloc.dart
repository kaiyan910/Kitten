import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/network/api_provider.dart';
import 'package:kitten/src/core/network/remote_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
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

  save(String id) async {}

  changeStatusBarStyle(Color color, StatusBarStyle style) async {
    await FlutterStatusbarManager.setColor(color, animated: true);
    await FlutterStatusbarManager.setStyle(style);
  }

  dispose() {
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
