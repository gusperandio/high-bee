import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSingleton {
  // Crie uma instância singleton da classe DatabaseHelper
  static final DatabaseSingleton _instance = DatabaseSingleton._init();
  static Database? _database;

  DatabaseSingleton._init();

  static DatabaseSingleton get instance => _instance;

  // Getter assíncrono para o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Inicialize o banco de dados se ele ainda não existir
    _database = await _initDB('cache.db');
    return _database!;
  }

  // Método para inicializar o banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Método para criar a tabela
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cache(
        id TEXT PRIMARY KEY,
        value TEXT,
        exp TEXT,
        tag TEXT
      );
      ''');
  }

  // Método para fechar o banco de dados
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
