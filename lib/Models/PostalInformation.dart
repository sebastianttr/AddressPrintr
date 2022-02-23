import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import "dart:io";
import "package:path/path.dart";

class PostalInformation {
  final String fullName;
  final String streetInformation;
  final String cityInformation;

  PostalInformation({
    required this.fullName,
    required this.cityInformation,
    required this.streetInformation,
  });

  factory PostalInformation.fromMap(Map<String, dynamic> json) =>
      PostalInformation(
          fullName: json['fullName'],
          cityInformation: json["streetInformation"],
          streetInformation: json["cityInformation"]);

  PostalInformation.fromJson(Map<String, dynamic> json)
      : cityInformation = json["cityInformation"],
        fullName = json["fullName"],
        streetInformation = json["streetInformation"];

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'streetInformation': streetInformation,
        'cityInformation': cityInformation
      };
}

// This is an example of SQFLite
class DataBaseHelper {
  //constructor that does absolutly N O T H I N G
  DataBaseHelper._privateContructor();

  static final DataBaseHelper instance = DataBaseHelper._privateContructor();

  static Database? _database;

  // ??= assigen _initDatase() to _database only if _database is null and do this asynchronously and return the private database property
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'postalInfo.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE postalinformation(
        id INTEGER PRIMARY KEY,
        fullName TEXT,
        streetInformation TEXT,
        cityInformation TEXT
      )
    ''');
  }

  Future<List<PostalInformation>> getPostalInfo() async {
    Database db = await instance
        .database; // singleton -> it gets the database property and when it does not exist, it calls the initbase function to create it.
    var postalInfo = await db.query('postalinformation', orderBy: 'fullName');
    Object postalInformationList = postalInfo.isNotEmpty
        ? postalInfo.map((e) => PostalInformation.fromMap(e))
        : [];
    return postalInformationList as List<PostalInformation>;
  }

  Future<int> add(PostalInformation postalInformation) async {
    Database db = await instance.database; // singleton
    return await db.insert("postalinformation", postalInformation.toJson());
  }
}
