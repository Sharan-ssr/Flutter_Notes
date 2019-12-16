import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Provider{
  static Database db;
  static Future open() async{
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
    version: 1,
    onCreate: (Database db, int version)async{
      db.execute('''
      create table Notes(
        id integer primary key autoincrement,
        title text not null,
        text text not null
      );
      ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getNoteList() async{
    if(db == null){
      await open();
    }
    return await db.query('Notes');
  }

  static Future insertnote(Map<String, dynamic>note)async{
    await db.insert('Notes', note);
  }

  static Future updatenote(Map<String, dynamic>note)async{
     await db.update('Notes', note,where: 'id = ?',whereArgs: [note['id']]);
  } 

  static Future delete(int id)async{
    await db.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}