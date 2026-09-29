import 'package:arsip/l10n/app_localizations.dart';
import 'package:arsip/screens/create_note_screen.dart';
import 'package:arsip/screens/home_screen.dart';
import 'package:arsip/screens/note_detail_screen.dart';
import 'package:arsip/screens/search_notes_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arsip',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(scheme: FlexScheme.shadBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.shadBlue),
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateNoteScreen.routeName: (context) => CreateNoteScreen(),
        NoteDetailScreen.routeName: (context) => NoteDetailScreen(),
        SearchNotesScreen.routeName: (context) => SearchNotesScreen(),
      },
    );
  }
}
