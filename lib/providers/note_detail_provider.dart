import 'package:arsip/databases/note_database.dart';
import 'package:arsip/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final noteDetailProvider =
    NotifierProvider.family<NoteDetailNotifier, bool, Note>(
      NoteDetailNotifier.new,
    );

class NoteDetailNotifier extends Notifier<bool> {
  final Note args;

  final titleController = TextEditingController(text: '');
  final contentController = TextEditingController(text: '');

  new(this.args);

  @override
  bool build() {
    ref.onDispose(() {
      titleController.dispose();
      contentController.dispose();
    });

    titleController.text = args.title;
    contentController.text = args.content;
    return args.isPinned;
  }

  void togglePinned() {
    state = !state;
  }

  Future<void> updateNote() async {
    final db = NoteDatabase();

    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      await db.deleteNoteById(args.id!);
      return;
    }

    final now = DateTime.now();
    await db.updateNoteById(args.id!, title, content, state, now);
  }

  Future<void> deleteNote() async {
    final db = NoteDatabase();
    await db.deleteNoteById(args.id!);
  }
}
