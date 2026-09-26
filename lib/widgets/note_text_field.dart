import 'package:material_ui/material_ui.dart';

class NoteTextField extends StatelessWidget {
  final String hintText;
  final int maxLength;
  final TextStyle textStyle;
  final Color hintTextColor;
  final TextEditingController controller;

  const new({
    super.key,
    required this.hintText,
    required this.maxLength,
    required this.textStyle,
    required this.hintTextColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
