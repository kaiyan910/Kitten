// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => DatabaseProvider());
    container.registerSingleton((c) => LocalRepository(c<DatabaseProvider>()));
    container.registerSingleton((c) => ApiClient());
    container.registerSingleton((c) => ApiProvider(c<ApiClient>()));
    container.registerSingleton((c) => RemoteRepository(c<ApiProvider>()));
    container.registerSingleton((c) => PreferencesRepository());
  }
}
