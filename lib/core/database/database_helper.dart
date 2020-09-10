import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "montage.db";
  static final _databaseVersion = 1;

  static final table = 'user_table';
  static final colId = '_id';
  static final colName = 'name';
  static final colEmail = 'email';
  static final colUserName = 'user';
  static final colPassword = 'password';
  static final colAddress = 'address';
  static final colGender = 'gender';
  static final colImgUrl = 'img';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $colId INTEGER PRIMARY KEY,
            $colName TEXT NOT NULL,
            $colEmail TEXT NOT NULL,
            $colUserName TEXT NOT NULL,
            $colPassword TEXT NOT NULL,
            $colAddress TEXT NOT NULL,
            $colGender TEXT NOT NULL,
            $colImgUrl TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[colId];
    return await db.update(table, row, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> delete(String email, String password) async {
    Database db = await instance.database;
    return await db.delete(table,
        where: '$colEmail = ? AND $colPassword = ?', whereArgs: [email, password]);
  }
}
