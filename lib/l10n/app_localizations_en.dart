// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Arsip';

  @override
  String get homeScreenEmptyNotesTitle => 'You don\'t have any notes yet';

  @override
  String get homeScreenEmptyNotesDescription =>
      'You can create notes as to-do lists, reminders, or a place to keep your ideas.';

  @override
  String get createNoteScreenTitleHintText => 'Note title';

  @override
  String get createNoteScreenContentHintText => 'Note content';

  @override
  String get deleteNoteWidgetTitle => 'Delete Note';

  @override
  String get deleteNoteWidgetDescription =>
      'Are you sure you want to delete this note?';

  @override
  String get deleteNoteWidgetAgreement => 'Yes';

  @override
  String get deleteNoteWidgetDisagreement => 'No';

  @override
  String get searchNotesScreenSearchInputHintText => 'Search notes';

  @override
  String get searchNotesScreenEmptyNotesTitle => 'Search your notes';

  @override
  String get searchNotesScreenEmptyNotesDescription =>
      'You can type keywords in the search field above.';

  @override
  String fetchNotesError(String error) {
    return 'Failed to load notes: $error';
  }

  @override
  String get pinnedNotesLabel => 'Pinned';

  @override
  String get unpinnedNotesLabel => 'Others';
}
