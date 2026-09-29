import 'package:arsip/providers/home_provider.dart';
import 'package:arsip/screens/create_note_screen.dart';
import 'package:arsip/screens/search_notes_screen.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:arsip/widgets/all_notes.dart';
import 'package:arsip/widgets/empty_notes.dart';
import 'package:arsip/widgets/unpinned_notes.dart';
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
          if (notes.pinnedNotes.isEmpty && notes.unpinnedNotes.isEmpty) {
            return EmptyNotes(
              svgPath: 'assets/undraw_add_notes.svg',
              title: 'Anda belum memiliki catatan',
              description: 'Anda dapat membuat catatan sebagai daftar tugas, pengingat, atau sarana menyimpan ide-ide Anda',
            );
          }

          if (notes.pinnedNotes.isNotEmpty) {
            return AllNotes(
              pinnedNotes: notes.pinnedNotes,
              unpinedNotes: notes.unpinnedNotes,
              fetchNotes: notfiier.fetchNotes,
              context: context,
            );
          } else {
            return UnpinnedNotes(
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
}
