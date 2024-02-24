import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'package:wisata_cirebon/model/user_model.dart';

class dbHelper {
  static Database? _db;
  static const DB_Name = 'userdb';

  static const String Table_User = 'users';
  static const String Table_Data = 'dataWisata';
  static const int Version = 1;

  static const String c_email = 'email';
  static const String c_username = 'username';
  static const String c_password = 'password';

  static const String c_wisata = 'wisata';
  static const String c_alamat = 'alamat';
  static const String c_deskripsi = 'deskripsi';
  static const String c_hari = 'hari';
  static const String c_jam = 'jam';
  static const String c_harga = 'harga';
  

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbHelper.DB_Name);
    var db = await openDatabase(path,
        version: dbHelper.Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute('CREATE TABLE $Table_User ('
        'id INTEGER NOT NULL PRIMARY KEY,'
        '$c_email TEXT NOT NULL,'
        '$c_username TEXT NOT NULL,'
        '$c_password TEXT NOT NULL'
        ')');
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel> getLogin(String username, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$c_username = '$username' AND "
        "$c_password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }
    return null!;
  }

  static void refreshImages() {}
}
