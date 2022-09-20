import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'doggie_database.db'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //       'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  //     );
  //   },
  //   version: 1,
  // );
  // // Define a function that inserts dogs into the database
  // Future<void> insertDog(Dog dog) async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Insert the Dog into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'dogs',
  //     dog.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // } // Create a Dog and add it to the dogs table

  // var fido = const Dog(
  //   id: 0,
  //   name: 'Fido',
  //   age: 35,
  // );

  // await insertDog(fido).then((value) => log('succefuly insert'));
  // // A method that retrieves all the dogs from the dogs table.

  // Future<List<Dog>> dogs() async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('dogs');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return Dog(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       age: maps[i]['age'],
  //     );
  //   });
  // }

  // List<Dog> list = await dogs();
  // log(list.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
