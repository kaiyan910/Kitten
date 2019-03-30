import 'package:flutter/material.dart';
import 'package:kitten/generated/i18n.dart';
import 'package:kitten/src/common/mixins/locale_handler.dart';
import 'package:kitten/src/core/bloc/app_bloc.dart';
import 'package:kitten/src/core/bloc/bloc.dart';
import 'package:kitten/src/core/di/injector.dart';
import 'package:kitten/src/core/locale/overridden_localizations_delegate.dart';
import 'package:kitten/src/core/preferences/preferences_repository.dart';
import 'package:kitten/src/module/main/ui/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main() {
  inject();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with LocaleHandler {
  final AppBloc _bloc =
      AppBloc(kiwi.Container().resolve<PreferencesRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      bloc: _bloc,
      child: StreamBuilder<Locale>(
        stream: _bloc.locale,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
          return MaterialApp(
            localizationsDelegates: [
              OverriddenLocalizationsDelegate(snapshot.data),
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supported) {
              var resolvedLocale = resolveLocale(locale, supported);
              _bloc.saveStartupLocale(resolvedLocale);
              return resolvedLocale;
            },
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
