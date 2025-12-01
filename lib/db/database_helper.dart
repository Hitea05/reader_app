import 'package:path/path.dart';
import 'package:reader_app/models/book.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'book_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
    CREATE TABLE $_tableName(
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    authors TEXT NOT NULL,
    publisher TEXT,
    publishedDate TEXT,
    description TEXT,
    industryIdentifiers TEXT,
    pageCount INTEGER,
    categories TEXT,
    language TEXT,
    imageLinks TEXT,
    previewLink TEXT,
    infoLink TEXT,
    subtitle TEXT
    )
    ''');
  }

  Future<int> insert(Book book) async {
    Database db = await instance.database;
    return await db.insert(
      _tableName,
      book.toJson(),
      conflictAlgorithm: .replace,
    );
  }

  Future<List<Book>> readAllBook() async {
    Database db = await instance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty
        ? books.map((bookdata) => Book.fromJsonDatabase(bookdata)).toList()
        : [];
  }
}
