import 'package:arsip/models/note.dart';
import 'package:arsip/screens/note_detail_screen.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/note_item.dart';
import 'package:material_ui/material_ui.dart';

class NoteList extends StatelessWidget {
  final String title;
  final List<Note> notes;
  final BuildContext context;
  final Future<void> Function() fetchNotes;

  const new({
    super.key,
    required this.title,
    required this.notes,
    required this.context,
    required this.fetchNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
            child: Text(title, textAlign: TextAlign.start),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: notes.map((note) {
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
            }).toList(),
          ),
        ],
      ),
    );
  }
}
