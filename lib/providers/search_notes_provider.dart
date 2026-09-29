import 'dart:async';

import 'package:arsip/databases/note_database.dart';
import 'package:arsip/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final searchNotesProvider =
    AsyncNotifierProvider<SearchNotesNotifier, List<Note>>(
      SearchNotesNotifier.new,
    );

class SearchNotesNotifier extends AsyncNotifier<List<Note>> {
  final searchController = TextEditingController(text: '');

  @override
  FutureOr<List<Note>> build() {
    ref.onDispose(() {
      searchController.dispose();
    });
    return [];
  }

  Future<void> searchNotes() async {
    final db = NoteDatabase();
    final keyword = searchController.text.trim();
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await db.searchNotes(keyword);
    });
  }
}
