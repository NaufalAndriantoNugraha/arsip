import 'package:arsip/models/note.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/note_list.dart';
import 'package:material_ui/material_ui.dart';

class AllNotes extends StatelessWidget {
  final List<Note> pinnedNotes;
  final List<Note> unpinedNotes;
  final Future<void> Function() fetchNotes;
  final BuildContext context;

  const new({
    super.key,
    required this.pinnedNotes,
    required this.unpinedNotes,
    required this.context,
    required this.fetchNotes,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.xl,
        children: [
          NoteList(
            title: 'Disematkan',
            notes: pinnedNotes,
            fetchNotes: fetchNotes,
            context: context,
          ),
          NoteList(
            title: 'Lainnya',
            notes: unpinedNotes,
            fetchNotes: fetchNotes,
            context: context,
          ),
        ],
      ),
    );
  }
}
