import 'package:flutter/material.dart';
import 'package:kitten/src/module/favourite/bloc/favourite_bloc.dart';
import 'package:kitten/src/module/main/bloc/main_bloc.dart';
import 'package:kitten/src/module/search/bloc/search_bloc.dart';

class FavouriteBlocProvider extends InheritedWidget {
  final FavouriteBloc bloc;

  FavouriteBlocProvider({Key key, Widget child})
      : bloc = FavouriteBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static FavouriteBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(FavouriteBlocProvider)
              as FavouriteBlocProvider)
          .bloc;
}
