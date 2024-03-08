import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocablury/sqflite_database/model/liked_flash_cards_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "LikedFlashCards.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE LikedFlashCards(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, antonyms TEXT NOT NULL, synonyms TEXT NOT NULL);",
      ),
      version: _version,
    );
  }

  static Future<int> addNote(LikedFlashCardsModel note) async {
    final db = await _getDB();
    return await db.insert(
      "LikedFlashCards",
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateNote(LikedFlashCardsModel note) async {
    final db = await _getDB();
    return await db.update(
      "LikedFlashCards",
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteNote(LikedFlashCardsModel note) async {
    final db = await _getDB();
    return await db.delete(
      "LikedFlashCards",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<LikedFlashCardsModel>?> getAllData() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      "LikedFlashCards",
    );

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => LikedFlashCardsModel.fromJson(maps[index]),
    );
  }

  static Future<void> deleteAllData() async {
    final db = await _getDB();
    await db.delete("LikedFlashCards");
  }



  static Future<bool> isItemExists(LikedFlashCardsModel item) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      "LikedFlashCards",
      where: 'title = ?',
      whereArgs: [item.title], // Assuming 'title' is the field used for comparison
    );

    return maps.isNotEmpty;
  }

}
