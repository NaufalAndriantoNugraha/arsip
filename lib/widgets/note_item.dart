import 'package:arsip/models/note.dart';
import 'package:arsip/utils/spacing.dart';
import 'package:material_ui/material_ui.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final void Function() onTap;

  const new({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xl,
            vertical: Spacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title, maxLines: 2, style: theme.textTheme.titleMedium),
              const SizedBox(height: Spacing.sm),
              Text(
                note.content,
                maxLines: 8,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
