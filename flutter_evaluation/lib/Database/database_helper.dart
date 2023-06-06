import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "NewYorkTimes.db";
  static const _databaseVersion = 1;

  static const mostViewed = 'most_viewed';
  static const mostEmailed = 'most_emailed';
  static const mostShared = 'most_shared';

  static const columnId = 'id';
  static const columnName = 'title';
  static const columnDate = 'published_date';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $mostViewed (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $mostEmailed (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $mostShared (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertMostViewed(Map<String, dynamic> row) async {
    return await _db.insert(mostViewed, row);
  }

  Future<int> insertMostShared(Map<String, dynamic> row) async {
    return await _db.insert(mostShared, row);
  }

  Future<int> insertMostEmailed(Map<String, dynamic> row) async {
    return await _db.insert(mostEmailed, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> getMostViewed() async {
    return await _db.query(mostViewed);
  }

  Future<List<Map<String, dynamic>>> getMostShared() async {
    return await _db.query(mostShared);
  }

  Future<List<Map<String, dynamic>>> getMostEmailed() async {
    return await _db.query(mostEmailed);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteMostViewed() async {
    return await _db.delete(mostViewed);
  }

  Future<int> deleteMostShared() async {
    return await _db.delete(mostShared);
  }

  Future<int> deleteMostEmailed() async {
    return await _db.delete(mostEmailed);
  }
}
