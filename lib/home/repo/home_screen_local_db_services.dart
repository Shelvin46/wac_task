import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wac_task/home/model/home_model_class.dart';

///[HomeScreenLocalDbServices] is a class that is used to store and retrieve data from local database
///using sqflite package.
///[storeHomeData] is a method that is used to store the data in the local database.
///[getHomeData] is a method that is used to retrieve the data from the local database.
class HomeScreenLocalDbServices {
  ///[HomeScreenLocalDbServices] is a private constructor that is used to create an instance of [HomeScreenLocalDbServices].
  static final HomeScreenLocalDbServices _instance =
      HomeScreenLocalDbServices._internal();

  factory HomeScreenLocalDbServices() => _instance;

  ///[database] is a method that is used to get the database.
  static Database? _database;

  HomeScreenLocalDbServices._internal();

  ///[database] is a method that is used to get the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  ///[_initDatabase] is a method that is used to initialize the database.
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  ///[_onCreate] is a method that is used to create the table in database.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE home_data (
        id INTEGER PRIMARY KEY,
        data TEXT
      )
    ''');
  }

  static Future<void> storeHomeData(List<ProductDetails> productDetails) async {
    final db = await _instance.database;

    // Convert productDetails to JSON string
    String newData = json.encode(
      productDetails.map((e) => e.toJson()).toList(),
    );

    // Query the database to check if the data already exists
    final List<Map<String, dynamic>> maps = await db.query('home_data');

    if (maps.isNotEmpty) {
      // Compare existing data with new data
      String existingData = maps.first['data'];
      if (existingData == newData) {
        // Data already exists, no need to insert
        return;
      }
    }

    // Insert new data if it doesn't already exist
    await db.insert(
      'home_data',
      {'data': newData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ProductDetails>> getHomeData() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query('home_data');

    if (maps.isNotEmpty) {
      // Convert JSON string to List<ProductDetails>
      List<ProductDetails> productDetails = List<ProductDetails>.from(
        json.decode(maps.first['data']).map((x) => ProductDetails.fromJson(x)),
      );

      return productDetails;
    } else {
      return [];
    }
  }
}
