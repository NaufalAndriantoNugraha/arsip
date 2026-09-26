import 'dart:async';

import 'package:arsip/databases/note_database.dart';
import 'package:arsip/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, List<Note>>(
  HomeNotifier.new,
);

class HomeNotifier extends AsyncNotifier<List<Note>> {
  @override
  FutureOr<List<Note>> build() async {
    final db = NoteDatabase();
    final notes = await db.getNotes();
    return notes;
  }

  Future<void> fetchNotes() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final db = NoteDatabase();
      return await db.getNotes();
    });
  }
}
