import 'package:arsip/models/note.dart';
import 'package:arsip/screens/note_detail_screen.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/note_item.dart';
import 'package:flutter/material.dart';

class UnpinnedNotes extends StatelessWidget {
  final List<Note> notes;
  final Future<void> Function() fetchNotes;

  const new({super.key, required this.notes, required this.fetchNotes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteItem(
            note: note,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                NoteDetailScreen.routeName,
                arguments: note,
              );
              await fetchNotes();
            },
          );
        },
      ),
    );
  }
}
