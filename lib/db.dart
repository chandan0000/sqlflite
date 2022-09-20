import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

import 'package:fvx_deepdive/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class PersonDatabaseProvider {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'userinfo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,email INTEGER NOT NULL, address TEXT NOT NULL, phone INTEGER NOT NULL)",
    );
  }

  Future<UserDetails> insert(UserDetails userDetails) async {
    var dbClient = await db;
    await dbClient!.insert(
      'user',
      userDetails.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userDetails;
  }

  Future<List<UserDetails>> getUserDetails() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('user');

    return queryResult.map((e) => UserDetails.fromMap(e)).toList();
  }

  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      'user',
    );
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('user', where: 'id=?', whereArgs: [id]);
  }
  
  // Future<int> updateQuantity(NotesModel notesModel) async {
  //   var dbClient = await db;
  //   return await dbClient!.update(
  //     'notes',
  //     notesModel.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [notesModel.id],
  //   );
  // }


  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
