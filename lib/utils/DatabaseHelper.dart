import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shamba_app/models/User.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String userTable = 'User';

  String attendantTable = 'Attendant';

  String colID = 'ID';
  String colUserID = 'UserID';
  String colFirstName = 'FirstName';
  String colLastName = 'LastName';
  String colPhoneNumber = 'PhoneNumber';
  String colIsCheck = 'IsCheck';
  String colAttendantDate = 'AttendantDate';
  String colStatus = 'Status';

  DatabaseHelper._createInstance(); //  constructor

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //  directory path fr both Android and iOS ya db.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.path, 'shambaRecords.db');


    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colUserID NVARCHAR(50), '
        '$colLastName NVARCHAR(50),$colFirstName NVARCHAR(50),$colPhoneNumber NVARCHAR(50),$colIsCheck INTEGER,$colAttendantDate NVARCHAR(50)) ');

  }
  Future<List<User>> getUserList() async {
    var userMapList = await usersMapList();
    int count = userMapList.length;
    List<User> cartList = List<User>.empty(growable: true);
    for (int i = 0; i < count; i++) {
      cartList.add(User.fromMapObject(userMapList[i]));
    }
    return cartList;
  }

  Future<List<Map<String, dynamic>>> usersMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $userTable order by $colPhone ASC');
    var result = await db.query(userTable,
        orderBy: '$colID DESC');
    return result;
  }



  Future<int> addUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  Future<int> updateUser(String userID, isPresent) async {
    var db = await this.database;
    var result = await db.rawUpdate(
        'UPDATE  $userTable SET $colIsCheck=$isPresent  WHERE $colUserID= $userID ');
    return result;
  }



}
