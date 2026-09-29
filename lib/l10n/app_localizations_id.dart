// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Arsip';

  @override
  String get homeScreenEmptyNotesTitle => 'Anda belum memiliki catatan';

  @override
  String get homeScreenEmptyNotesDescription =>
      'Anda dapat membuat catatan sebagai daftar tugas, pengingat, atau sarana menyimpan ide-ide Anda.';

  @override
  String get createNoteScreenTitleHintText => 'Judul catatan';

  @override
  String get createNoteScreenContentHintText => 'Isi catatan';

  @override
  String get deleteNoteWidgetTitle => 'Hapus Catatan';

  @override
  String get deleteNoteWidgetDescription =>
      'Apakah Anda yakin ingin menghapus catatan ini?';

  @override
  String get deleteNoteWidgetAgreement => 'Iya';

  @override
  String get deleteNoteWidgetDisagreement => 'Tidak';

  @override
  String get searchNotesScreenSearchInputHintText => 'Cari catatan';

  @override
  String get searchNotesScreenEmptyNotesTitle => 'Cari catatan Anda';

  @override
  String get searchNotesScreenEmptyNotesDescription =>
      'Anda dapat mengetikkan kata kunci pada kolom pencarian di atas.';

  @override
  String fetchNotesError(String error) {
    return 'Gagal memuat catatan: $error';
  }

  @override
  String get pinnedNotesLabel => 'Disematkan';

  @override
  String get unpinnedNotesLabel => 'Lainnya';
}
