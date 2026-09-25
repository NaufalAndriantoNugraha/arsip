import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Expanded(child: Text('Hello, World!'))),
    );
  }
}
