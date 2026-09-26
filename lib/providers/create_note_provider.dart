import 'package:arsip/databases/note_database.dart';
import 'package:arsip/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final createNoteProvider = NotifierProvider<CreateNoteNotifier, bool>(
  CreateNoteNotifier.new,
);

class CreateNoteNotifier extends Notifier<bool> {
  final titleController = TextEditingController(text: '');
  final contentController = TextEditingController(text: '');

  @override
  bool build() {
    ref.onDispose(() {
      titleController.dispose();
      contentController.dispose();
    });
    return false;
  }

  void togglePinned() {
    state = !state;
  }

  Future<void> createNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isNotEmpty || content.isNotEmpty) {
      final time = DateTime.now();
      final note = Note(
        title: title,
        content: content,
        isPinned: state,
        createdAt: time,
        updatedAt: time,
      );

      final db = NoteDatabase();
      await db.insertNote(note);
    }

    titleController.clear();
    contentController.clear();
    state = false;
  }
}
