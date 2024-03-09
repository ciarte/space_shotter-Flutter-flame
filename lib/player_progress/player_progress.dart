import 'dart:async';

import 'package:flutter/material.dart';

import 'persistence/local_storage_player_progress_persistence.dart';
import 'package:flutter/foundation.dart';

import 'persistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  PlayerProgress({PlayerProgressPersistence? store})
      : _store = store ?? LocalStoragePlayerProgressPersistence() {
    getLatestFromStore();
  }

  /// TODO: If needed, replace this with some other mechanism for saving
  ///       the player's progress. Currently, this uses the local storage
  ///       (i.e. NSUserDefaults on iOS, SharedPreferences on Android
  ///       or local storage on the web).
  final PlayerProgressPersistence _store;

  List<int> _levelsFinished = [];
  List<int> _worldsFinished = [];

  /// The times for the levels that the player has finished so far.
  List<int> get levels => _levelsFinished;
  List<int> get worlds => _worldsFinished;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore() async {
    final levelsFinished = await _store.getFinishedLevels();
    final worldsFinished = await _store.getFinishedWorlds();
    if (!listEquals(_worldsFinished, worldsFinished)) {
      _worldsFinished = _worldsFinished;
      notifyListeners();
    }
    if (!listEquals(_levelsFinished, levelsFinished)) {
      _levelsFinished = _levelsFinished;
      notifyListeners();
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _store.reset();
    _levelsFinished.clear();
    _worldsFinished.clear();
    notifyListeners();
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelFinished(int level, int time) {
    if (level < _levelsFinished.length - 1) {
      final currentTime = _levelsFinished[level - 1];
      if (time < currentTime) {
        _levelsFinished[level - 1] = time;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      }
    } else {
      _levelsFinished.add(time);
      notifyListeners();
      unawaited(_store.saveLevelFinished(level, time));
    }
  }

  void setWorldFinished(int world, int time) {
    if (world < _worldsFinished.length - 1) {
      final currentTime = _worldsFinished[world - 1];
      if (time < currentTime) {
        _worldsFinished[world - 1] = time;
        notifyListeners();
        unawaited(_store.saveWorldFinished(world));
      }
    } else {
      _levelsFinished.add(TimeOfDay.hoursPerDay);
      notifyListeners();
      unawaited(_store.saveWorldFinished(world));
    }
  }
}
