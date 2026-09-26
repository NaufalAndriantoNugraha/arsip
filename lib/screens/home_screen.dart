import 'package:arsip/providers/home_provider.dart';
import 'package:arsip/screens/create_note_screen.dart';
import 'package:arsip/screens/note_detail_screen.dart';
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
          IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.search)),
          SizedBox(width: Spacing.md),
        ],
      ),
      body: notesAsync.when(
        data: (notes) {
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
                    await notfiier.fetchNotes();
                  },
                );
              },
            ),
          );
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
