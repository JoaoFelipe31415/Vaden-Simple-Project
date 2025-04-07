import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  late final Database _db;

  DatabaseHelper() {
    _createDatabase();
    _createTable();
  }

  void _createTable() {
    _db.execute('''
    CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL,
      year int NOT NULL
    )
  ''');
  }

  void insert(String name, int year) {
    _db.execute('INSERT INTO books (name, year) VALUES (?,?)', [name, year]);
  }

  ResultSet getAll() {
    return _db.select('SELECT * FROM books');
  }

  ResultSet getOneBook(int id) {
    return _db.select('SELECT * FROM books Where id = (?)', [id]);
  }

  void deleteBook(int id) {
    _db.execute('DELETE FROM books Where id = (?)', [id]);
  }

  void close() {
    _db.dispose();
  }

  void _createDatabase() {
    _db = sqlite3.openInMemory();
  }
}
