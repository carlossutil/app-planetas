import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/planet.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('planets.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE planets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        distancia REAL NOT NULL,
        tamanho REAL NOT NULL,
        apelido TEXT
      )
    ''');
  }

  Future<int> createPlanet(Planet planet) async {
    final db = await instance.database;
    return await db.insert('planets', planet.toMap());
  }

  Future<List<Planet>> getPlanets() async {
    final db = await instance.database;
    final result = await db.query('planets');
    return result.map((e) => Planet.fromMap(e)).toList();
  }

  Future<int> updatePlanet(Planet planet) async {
    final db = await instance.database;
    return await db.update(
      'planets',
      planet.toMap(),
      where: 'id = ?',
      whereArgs: [planet.id],
    );
  }

  Future<int> deletePlanet(int id) async {
    final db = await instance.database;
    return await db.delete(
      'planets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}