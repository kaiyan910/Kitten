import 'package:flutter/material.dart';
import 'package:kitten/src/core/bloc/app_bloc.dart';

class AppBlocProvider extends InheritedWidget {
  final AppBloc bloc;

  AppBlocProvider(this.bloc, {Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppBlocProvider)
              as AppBlocProvider)
          .bloc;
}
