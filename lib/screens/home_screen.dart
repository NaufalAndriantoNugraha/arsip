import 'package:arsip/models/note.dart';
import 'package:arsip/providers/home_provider.dart';
import 'package:arsip/screens/create_note_screen.dart';
import 'package:arsip/screens/note_detail_screen.dart';
import 'package:arsip/screens/search_notes_screen.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/note_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = '/';

  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final notfiier = ref.read(homeProvider.notifier);
    final notesAsync = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Arsip'),
        titleTextStyle: theme.textTheme.headlineLarge,
        actions: [
          IconButton.filledTonal(
            onPressed: () async {
              await Navigator.pushNamed(context, SearchNotesScreen.routeName);
              await notfiier.fetchNotes();
            },
            icon: Icon(Icons.search),
          ),
          SizedBox(width: Spacing.md),
        ],
      ),
      body: notesAsync.when(
        data: (notes) {
          if (notes.pinnedNotes.isNotEmpty) {
            return allNotes(
              pinnedNotes: notes.pinnedNotes,
              unpinedNotes: notes.unpinnedNotes,
              fetchNotes: notfiier.fetchNotes,
              context: context,
            );
          } else {
            return unpinnedNotes(
              notes: notes.unpinnedNotes,
              fetchNotes: notfiier.fetchNotes,
            );
          }
        },
        error: (error, stackTrace) {
          return Center(child: Text('Gagal memuat catatan: $error'));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, CreateNoteScreen.routeName);
          await notfiier.fetchNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget allNotes({
    required List<Note> pinnedNotes,
    required List<Note> unpinedNotes,
    required Future<void> Function() fetchNotes,
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      child: Column(
        spacing: Spacing.xl,
        children: [
          noteList(
            title: 'Disematkan',
            notes: pinnedNotes,
            fetchNotes: fetchNotes,
            context: context,
          ),
          noteList(
            title: 'Lainnya',
            notes: unpinedNotes,
            fetchNotes: fetchNotes,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget noteList({
    required String title,
    required List<Note> notes,
    required Future<void> Function() fetchNotes,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
            child: Text(title),
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

  Widget unpinnedNotes({
    required List<Note> notes,
    required Future<void> Function() fetchNotes,
  }) {
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
