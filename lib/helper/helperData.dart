import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'package:wisata_cirebon/model/user_model.dart';
import 'package:wisata_cirebon/model/photo.dart';

class HelperData {
  static Database? _db;
  static const DB_Name = 'datadb';

  static const String Table_Data = 'dataWisata';
  static const int Version = 1;
  static const String c_id = 'id';
  static const String c_wisata = 'wisata';
  static const String c_alamat = 'alamat';
  static const String c_deskripsi = 'deskripsi';
  static const String c_hari = 'hari';
  static const String c_jam = 'jam';
  static const String c_harga = 'harga';
  static const String c_photo = 'photoName';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, HelperData.DB_Name);
    var db = await openDatabase(path,
        version: HelperData.Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute('CREATE TABLE $Table_Data ('
        '$c_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$c_wisata TEXT NOT NULL,'
        '$c_alamat TEXT NOT NULL,'
        '$c_deskripsi TEXT NOT NULL,'
        '$c_hari TEXT NOT NULL,'
        '$c_jam TEXT NOT NULL,'
        '$c_harga TEXT NOT NULL,'
        '$c_photo TEXT NOT NULL'
        ')');
  }

  Future<int> savePhoto(Photo photo) async {
    var dbClient = await db;
    var result = await dbClient.insert(Table_Data, photo.toMap());
    return result;
  }

  Future getAllData() async {
     
    var dbClient = await db;
    var result = await dbClient.query(Table_Data,
        columns: [
          c_id,
          c_wisata,
          c_alamat,
          c_alamat,
          c_deskripsi,
          c_hari,
          c_jam,
          c_harga,
          c_photo
        ],
        limit: 500);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  // Future<int> saveData(UserModel user) async {
  //   var dbClient = await db;
  //   var res = await dbClient.insert(Table_Data, user.toMap());
  //   return res;
  // }

  // Future<int> imageSpec(Photo photo) async {
  //   var dbClient = await db;
  //   var result = db.update(Table_Data, photo.toMap(), where: '$id' )
  // }

  Future<List<Photo>> getData() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(Table_Data, columns: [
      c_id,
      c_wisata,
      c_alamat,
      c_deskripsi,
      c_hari,
      c_jam,
      c_harga,
      c_photo
    ]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (var i = 0; i < maps.length; i++) {
        photos.add(Photo.fromMap(maps[i]));
      }
    }
    return photos;
  }

  Future deleteNote(int? id) async {
    var dbClient = await db;
    return await dbClient.delete(Table_Data, where: '$id = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
