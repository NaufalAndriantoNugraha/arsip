import 'package:arsip/utils/spacing.dart';
import 'package:material_ui/material_ui.dart';

class CreateNoteScreen extends StatelessWidget {
  static const String routeName = '/create_note_screen';

  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.filledTonal(
            onPressed: () {},
            icon: Icon(Icons.push_pin_outlined),
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
              ),
              textField(
                hintText: 'Konten catatan',
                maxLength: 150,
                textStyle: theme.textTheme.bodyLarge!,
                hintTextColor: theme.hintColor,
              ),
            ],
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
  }) {
    return TextField(
      maxLength: maxLength,
      maxLines: null,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        border: InputBorder.none,
        counterText: '',
      ),
    );
  }
}
