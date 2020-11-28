import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  /// initialize a database then create a table in it called places
  /// with fields id as a primary key, title, image (path), latitude, longitude, address
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT,loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  /// insert a data map to a table in data base
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
  /// fetch all data in the table as select * from table
  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
