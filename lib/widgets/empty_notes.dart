import 'package:arsip/utils/spacing.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';

class EmptyNotes extends StatelessWidget {
  final String svgPath;
  final String title;
  final String description;

  const new({
    super.key,
    required this.svgPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgPath, width: 150),
          SizedBox(height: Spacing.xl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: Spacing.md),
          SizedBox(
            width: 300,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
