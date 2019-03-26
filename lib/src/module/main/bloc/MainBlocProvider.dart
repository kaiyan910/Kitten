import 'package:flutter/material.dart';
import 'package:kitten/src/module/main/bloc/MainBloc.dart';

class MainBlocProvider extends InheritedWidget {
  final MainBloc bloc;

  MainBlocProvider({Key key, Widget child})
      : bloc = MainBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MainBlocProvider)
              as MainBlocProvider)
          .bloc;
}
