import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "IndianEcommerce.db";
  static final _databaseVersion = 1;

  //SignUp DB Table Fields:-
  static final signUpTable = 'signUpTable';
  static final signUpId = '_id';
  static final fullName = 'fullName';
  static final userName = 'userName';
  static final password = 'password';
  static final dateTime = 'dateTime';

  //Add To Cart DB Table Fields:-
  static final addToCartTable = 'addToCartTable';
  static final productSerialNumber = "productSerialNumber";
  static final productTitle = "productTitle";
  static final productMrp = "productMrp";
  static final productDiscount = "productDiscount";
  static final productPrice = "productPrice";
  static final isFavourite = "isFavourite";

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //Here we are Creating SignUp Table:-
    await db.execute('''
          CREATE TABLE $signUpTable (
            $signUpId INTEGER PRIMARY KEY,
            $fullName TEXT NOT NULL,
            $userName TEXT NOT NULL,
            $password TEXT NOT NULL,
            $dateTime TEXT NOT NULL 
          )
          ''');

    //Here we are Creating Add To Cart Table:-
    await db.execute('''
          CREATE TABLE $addToCartTable (
            $productSerialNumber TEXT PRIMARY KEY,
            $productTitle TEXT NOT NULL,
            $productMrp INTEGER NOT NULL,
            $productDiscount INTEGER NOT NULL,
            $productPrice INTEGER NOT NULL,
            $isFavourite INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertSignUpData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(signUpTable, row);
  }

  //Insert Add To Cart Data in Table:-
  Future<int> insertAddToCartData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(addToCartTable, row);
  }

  //Below method is used to query All SignUp Table Data:-
  Future<List<Map<String, dynamic>>> queryAllSignUpRows() async {
    Database db = await instance.database;
    return await db.query(signUpTable);
  }

  //Below method is used to query All Shopping Cart Table Data:-
  Future<List<Map<String, dynamic>>> queryAllShoppingCartRows() async {
    Database db = await instance.database;
    return await db.query(addToCartTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> checkLogin(userID, userPassword) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $signUpTable WHERE $userName=? and $password=?',
        [userID, userPassword]));
  }

  //Below method is to count number of Products added in Shopping Cart:-
  Future<int> addedProductToCartCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $addToCartTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[signUpId];
    return await db
        .update(signUpTable, row, where: '$signUpId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(signUpTable, where: '$signUpId = ?', whereArgs: [id]);
  }

  //Below method is used to delete SignUpDB from App:-
  deleteSignUpDB() async {
    Database db = await instance.database;
    return await db.delete(signUpTable);
  }
}
