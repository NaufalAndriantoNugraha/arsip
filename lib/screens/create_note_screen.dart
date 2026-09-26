import 'package:arsip/providers/create_note_provider.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class CreateNoteScreen extends ConsumerWidget {
  static const String routeName = '/create_note_screen';

  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final notifier = ref.read(createNoteProvider.notifier);
    final isPinned = ref.watch(createNoteProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await notifier.createNote();
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              await notifier.createNote();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () => notifier.togglePinned(),
              icon: Icon(isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            ),
            SizedBox(width: Spacing.md),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xxxl),
          child: SingleChildScrollView(
            child: Column(
              children: [
                textField(
                  hintText: 'Judul Catatan',
                  maxLength: 150,
                  textStyle: theme.textTheme.titleLarge!,
                  hintTextColor: theme.hintColor,
                  controller: notifier.titleController,
                ),
                textField(
                  hintText: 'Konten catatan',
                  maxLength: 150,
                  textStyle: theme.textTheme.bodyLarge!,
                  hintTextColor: theme.hintColor,
                  controller: notifier.contentController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required int maxLength,
    required TextStyle textStyle,
    required Color hintTextColor,
    required TextEditingController controller,
  }) {
    return TextField(
      maxLength: maxLength,
      maxLines: null,
      style: textStyle,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        border: InputBorder.none,
        counterText: '',
      ),
    );
  }
}
