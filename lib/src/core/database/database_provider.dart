import 'dart:io';

import 'package:kitten/src/core/model/cat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseProvider {

  static const String TABLE_FAVOURITES = "favourites";

  Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await _init();
    return _database;
  }

  _init() async {
    final Directory document = await getApplicationDocumentsDirectory();
    final path = join(document.path, "kitten.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE $TABLE_FAVOURITES(
            id INTEGER PRIMARY KEY,
            cat_id TEXT,
            cat_url TEXT
          )
          """);
      },
    );
  }

  Future<List<Cat>> fetchFavourites() async {
    final db = await database;
    final result = await db.query(
      TABLE_FAVOURITES,
      columns: null,
    );

    return result.map((oneCat) => Cat.fromDatabase(oneCat)).toList();
  }

  Future<bool> hasFavourite(String id) async {
    final db = await database;
    final result = await db.query(TABLE_FAVOURITES,
        columns: null, where: "cat_id = ?", whereArgs: [id]);

    return result.length == 1;
  }

  Future<int> deleteAllFavourites() async {
    final db = await database;
    return db.delete(TABLE_FAVOURITES);
  }

  Future<int> deleteFavourite(String id) async {
    final db = await database;
    return db.delete(TABLE_FAVOURITES, where: "cat_id = ?", whereArgs: [id]);
  }

  Future<int> insertFavourite(Map<String, dynamic> map) async {
    final db = await database;

    return db.insert(
      TABLE_FAVOURITES,
      map,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
