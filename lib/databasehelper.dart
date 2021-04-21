import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class Databasehelper {
  static final _databasename = "persons.db";
  static final _databaseversion = 1;
  static final table = "my_table";

  static final columnId = 'id';
  static final columnUserName = 'username';
  static final columnpassword = 'password';
  static final columnName = 'name';
  static final columnemail = 'email';
  static final columnnumber = 'number';
  static Database _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    print(path);
    return await openDatabase(path,
        version: _databaseversion, password: "prashant", onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnUserName TEXT,
        $columnpassword TEXT,
        $columnName TEXT,
        $columnemail TEXT,
        $columnnumber TEXT
      )
      ''');
  }

//FOR INSERT DATA
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //query all row
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //spacific query
  Future<List<Map<String, dynamic>>> queryspacific(String username) async {
    Database db = await instance.database;
    // var res = await db.query(table, where: "age < ? ", whereArgs: [age]);
    var res = await db
        .rawQuery('SELECT * FROM my_table WHERE username =?', [username]);
    return res;
  }

//for delete database
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // for update
  Future<int> update(
    String username,
    String name,
    String number,
    String email,
  ) async {
    Database db = await instance.database;
    var res = await db.update(
        table, {"name": name, "email": email, "number": number},
        where: "username =?", whereArgs: [username]);
    return res;
  }
}
