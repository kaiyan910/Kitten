import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:kitten/src/common/mixins/status_bar_handler.dart';
import 'package:kitten/src/core/bloc/bloc.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/network/remote_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc with StatusBarHandler {

  final RemoteRepository _remoteRepository;
  final _searchResult = BehaviorSubject<SearchScreenState>();

  Observable<SearchScreenState> get searchResult => _searchResult.stream;

  SearchBloc(this._remoteRepository) {

    search();
    changeStatusBarStyle(Colors.white, StatusBarStyle.DARK_CONTENT);
  }

  search() async {
    final cats = await _remoteRepository.search(21, 1, "image/png");
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
