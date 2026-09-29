import 'package:arsip/providers/search_notes_provider.dart';
import 'package:arsip/screens/note_detail_screen.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/empty_notes.dart';
import 'package:arsip/widgets/note_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class SearchNotesScreen extends ConsumerWidget {
  static const String routeName = '/search_screen';

  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final notifier = ref.read(searchNotesProvider.notifier);
    final notesAsync = ref.watch(searchNotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: notifier.searchController,
          onChanged: (value) => notifier.searchNotes(),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Cari catatan',
            hintStyle: TextStyle(color: theme.hintColor),
          ),
        ),
      ),
      body: notesAsync.when(
        data: (notes) {
          if (notes.isEmpty) {
            return EmptyNotes(
              svgPath: 'assets/undraw_reading_notes.svg',
              title: 'Cari catatan Anda',
              description: 'Anda dapat mengetikkan kata kunci pada kolom pencarian di atas',
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: notes[index],
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      NoteDetailScreen.routeName,
                      arguments: notes[index],
                    );
                    await notifier.searchNotes();
                  },
                );
              },
            ),
          );
        },
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat catatan: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
