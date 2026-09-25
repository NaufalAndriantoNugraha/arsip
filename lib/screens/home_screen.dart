import 'package:arsip/utils/spacing.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Arsip'),
        titleTextStyle: theme.textTheme.headlineLarge,
        actions: [
          IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.search)),
          SizedBox(width: Spacing.md),
        ],
      ),
      body: Center(child: Expanded(child: Text('Hello, World!'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
