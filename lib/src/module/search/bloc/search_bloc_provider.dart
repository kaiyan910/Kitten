import 'package:flutter/material.dart';
import 'package:kitten/src/module/search/bloc/search_bloc.dart';

class SearchBlocProvider extends InheritedWidget {
  final SearchBloc bloc;

  SearchBlocProvider({Key key, Widget child})
      : bloc = SearchBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SearchBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SearchBlocProvider)
              as SearchBlocProvider)
          .bloc;
}
