import 'dart:ui';

import 'package:kitten/src/common/mixins/status_bar_handler.dart';
import 'package:kitten/src/core/bloc/bloc.dart';
import 'package:kitten/src/core/preferences/preferences_repository.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc with StatusBarHandler {
  final PreferencesRepository _preferencesRepository;

  final _locale = BehaviorSubject<Locale>();

  Observable<Locale> get locale => _locale.stream;

  AppBloc(this._preferencesRepository) {
    _initLocale();
  }

  _initLocale() async {
    String storedLocale = await _preferencesRepository.getLocale();

    if (storedLocale != null && storedLocale.isNotEmpty) {
      var split = storedLocale.split("_");
      Locale locale = Locale(split[0], split.length == 2 ? split[1] : "");
      _locale.sink.add(locale);
    }
  }

  updateLocale(Locale newLocale) async {
    await _preferencesRepository
        .setLocale("${newLocale.languageCode}_${newLocale.countryCode}");
    _locale.sink.add(newLocale);
  }

  saveStartupLocale(Locale newLocale) async {
    if (newLocale == null) return;

    String storedLocale = await _preferencesRepository.getLocale();
    print(
        "[DEBUG] storedLocale=${storedLocale.toString()} locale=${newLocale.toString()}");

    if (storedLocale == null || storedLocale.isEmpty) {
      await _preferencesRepository
          .setLocale("${newLocale.languageCode}_${newLocale.countryCode}");
      _locale.sink.add(newLocale);
    }
  }

  @override
  dispose() async {
    await _locale.drain();
    _locale.close();
  }
}
