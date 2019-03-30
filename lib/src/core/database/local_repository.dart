import 'package:kitten/src/core/database/database_provider.dart';
import 'package:kitten/src/core/model/cat.dart';

class LocalRepository {

  DatabaseProvider _databaseProvider;

  LocalRepository(this._databaseProvider);

  Future<List<Cat>> fetchFavourites() async =>
      _databaseProvider.fetchFavourites();

  Future<bool> hasFavourite(String id) async =>
      _databaseProvider.hasFavourite(id);

  Future<int> deleteAllFavourites() async =>
      _databaseProvider.deleteAllFavourites();

  Future<int> deleteFavourite(String id) async =>
      _databaseProvider.deleteFavourite(id);

  Future<int> insertFavourite(Map<String, dynamic> map) async =>
      _databaseProvider.insertFavourite(map);
}