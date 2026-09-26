import 'dart:async';

import 'package:arsip/databases/note_database.dart';
import 'package:arsip/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

class HomeState {
  final List<Note> pinnedNotes;
  final List<Note> unpinnedNotes;

  new({this.pinnedNotes = const [], this.unpinnedNotes = const []});

  HomeState copyWith({List<Note>? pinnedNotes, List<Note>? unpinnedNotes}) {
    return HomeState(
      pinnedNotes: pinnedNotes ?? this.pinnedNotes,
      unpinnedNotes: unpinnedNotes ?? this.unpinnedNotes,
    );
  }
}

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  FutureOr<HomeState> build() async {
    return loadNotes();
  }

  Future<HomeState> loadNotes() async {
    final db = NoteDatabase();
    final pinnedNotes = await db.getPinnedNotes();
    final unpinnedNotes = await db.getUnpinnedNotes();
    return HomeState(pinnedNotes: pinnedNotes, unpinnedNotes: unpinnedNotes);
  }

  Future<void> fetchNotes() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => loadNotes());
  }
}
