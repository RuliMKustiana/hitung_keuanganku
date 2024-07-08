import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hitung_keuangan/model/model_database.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tablePemasukan = 'pemasukan';
  final String tablePengeluaran = 'pengeluaran';

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hitung_keuangan.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tablePemasukan (
        id INTEGER PRIMARY KEY,
        tipe TEXT,
        keterangan TEXT,
        tanggal TEXT,
        jmlUang TEXT,
        kategori TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePengeluaran (
        id INTEGER PRIMARY KEY,
        tipe TEXT,
        keterangan TEXT,
        tanggal TEXT,
        jmlUang TEXT,
        kategori TEXT
      )
    ''');
  }

  Future<int> insertData(ModelDatabase data, String table) async {
    var dbClient = await db;
    return await dbClient.insert(table, data.toMap());
  }

  Future<int> updateData(ModelDatabase data, String table) async {
    var dbClient = await db;
    return await dbClient.update(table, data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }

  Future<int> deleteData(int id, String table) async {
    var dbClient = await db;
    return await dbClient.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    var dbClient = await db;
    return await dbClient.query(table);
  }
}