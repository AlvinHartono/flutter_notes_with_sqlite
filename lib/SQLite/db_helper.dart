import 'package:projext/models/note.dart';
import 'package:projext/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //database name
  final databaseName = "notes.db";

  //user table for login and signup purposes
  String userTable =
      "CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT);";

  //notes table
  String noteTable =
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, createdAt TEXT);";

  //Database initialization
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(userTable);
        await db.execute(noteTable);
      },
    );
  }

  //Finding users login
  Future<bool> login(User user) async {
    try {
      final Database db = await initDB();
      // var result = await db.rawQuery(
      //     "SELECT * FROM users WHERE username = '${user.username}' AND password = '${user.password}'");
      var result = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [user.username, user.password],
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  //Creating users with Sign Up
  Future<int> signup(User user) async {
    try {
      final Database db = await initDB();
      var result = db.insert('users', user.toMap());
      return result;
    } catch (e) {
      return 0;
    }
  }

  //Creating notes
  Future<int> createNote(Note note) async {
    final Database db = await initDB();

    return db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final Database db = await initDB();

    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(title, content, id) async {
    final Database db = await initDB();
    return db.rawUpdate('UPDATE notes SET title = ?, content = ?, WHERE = ?',
        [title, content, id]);
  }
}
