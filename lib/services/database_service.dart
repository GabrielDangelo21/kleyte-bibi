import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tabelaDeGastos = "tabela";
  final String _idTabela = "id";
  final String _tituloTabela = "title";
  final String _valorTabela = "value";
  //final String _dataTabela = "data";
  final String _quemTabela = "quem";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db6.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE $_tabelaDeGastos ('
            '$_idTabela INTEGER AUTO INCREMENT,'
            '$_tituloTabela TEXT,'
            '$_valorTabela REAL,'
            '$_quemTabela INTEGER'
            ')');
      },
    );
    return database;
  }

  void addTask(
    String title,
    double value,
    //String date,
    int quem,
  ) async {
    final db = await database;
    await db.insert(
      _tabelaDeGastos,
      {
        _tituloTabela: title,
        _valorTabela: value,
        //_dataTabela: date,
        _quemTabela: quem,
      },
    );
  }
}
