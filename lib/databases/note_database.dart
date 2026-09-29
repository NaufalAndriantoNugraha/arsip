import 'dart:async';

import 'package:arsip/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase _noteDatabase = NoteDatabase._internal();
  static Database? _database;
  static const String _databaseName = 'note_database.db';
  static const int _databaseVersion = 1;

  factory NoteDatabase() {
    return _noteDatabase;
  }

  NoteDatabase._internal();

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        is_pinned INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.rawInsert(
      '''
      INSERT INTO notes (
        title,
        content,
        is_pinned,
        created_at,
        updated_at
      ) VALUES (?, ?, ?, ?, ?)
    ''',
      [
        note.title,
        note.content,
        note.isPinned ? 1 : 0,
        note.createdAt.toIso8601String(),
        note.updatedAt.toIso8601String(),
      ],
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final notes = await db.rawQuery('SELECT * FROM notes ORDER BY id DESC');
    return List.generate(notes.length, (index) {
      return Note.fromMap(notes[index]);
    });
  }

  Future<List<Note>> getUnpinnedNotes() async {
    final db = await database;
    final notes = await db.rawQuery(
      'SELECT * FROM notes WHERE is_pinned = 0 ORDER BY id DESC',
    );
    return List.generate(notes.length, (index) {
      return Note.fromMap(notes[index]);
    });
  }

  Future<List<Note>> getPinnedNotes() async {
    final db = await database;
    final notes = await db.rawQuery(
      'SELECT * FROM notes WHERE is_pinned = 1 ORDER BY id DESC',
    );
    return List.generate(notes.length, (index) {
      return Note.fromMap(notes[index]);
    });
  }

  Future<void> updateNoteById(
    int id,
    String title,
    String content,
    bool isPinned,
    DateTime updatedAt,
  ) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE notes SET title=?, content=?, is_pinned=?, updated_at=? WHERE id=?',
      [title, content, isPinned ? 1 : 0, updatedAt.toIso8601String(), id],
    );
  }

  Future<void> deleteNoteById(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM notes WHERE id=?', [id]);
  }

  Future<List<Note>> searchNotes(String keyword) async {
    final db = await database;
    final notes = await db.rawQuery(
      'SELECT * FROM notes WHERE title LIKE ? OR content LIKE ?',
      ['%$keyword%', '%$keyword%'],
    );
    return List.generate(notes.length, (index) {
      return Note.fromMap(notes[index]);
    });
  }
}
