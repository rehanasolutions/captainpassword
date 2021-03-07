import 'dart:async';

import 'package:rxdart/subjects.dart';
// import 'package:rxdart/rxdart.dart';

class KeyService {
  final seconds = const Duration(seconds: 1);

  BehaviorSubject<String> _keySubject = BehaviorSubject.seeded(null);
  Stream get keystream$ => _keySubject.stream;
  String get currentKey => _keySubject.valueWrapper.value;

  BehaviorSubject<int> _remainingTimeSubject = BehaviorSubject.seeded(0);
  Stream get remainingTimestream$ => _remainingTimeSubject.stream;
  int get currentRemainingTime => _remainingTimeSubject.valueWrapper.value;

  DateTime _startTime;
  DateTime _endTime;

  Timer _timer;

  int getElapsedTime() {
    if (_startTime != null && _endTime != null) {
      DateTime _curTime = DateTime.now();
      if (_curTime.isAfter(_startTime)) {
        Duration difference = _curTime.difference(_startTime);
        return difference.inSeconds;
      }
    }
    return 0;
  }

  // int get getTotalTime => _totalDuration;

  int getRemainingTime() {
    if (_startTime != null && _endTime != null) {
      DateTime _curTime = DateTime.now();
      if (_curTime.isBefore(_endTime)) {
        Duration difference = _endTime.difference(_curTime);
        return difference.inSeconds;
      }
    }
    return 0;
  }

  void resetRemainingTime() {
    _timer.cancel();
    _timer = null;
    _startTime = null;
    _endTime = null;
    _keySubject.add(null);
    _remainingTimeSubject.add(0);
  }

  void _timerCallback(Timer timer) {
    // console(ConsoleLevel.Info, "Ticks: ${_timer.tick.toString()}");
    int remainingTime = getRemainingTime();
    if (remainingTime > 0) {
      _remainingTimeSubject.add(remainingTime);
    } else {
      resetRemainingTime();
    }
  }

  storeKey(String newValue, int duration) {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }

    _startTime = DateTime.now();
    _endTime = _startTime.add(new Duration(seconds: duration));

    _timer = new Timer.periodic(seconds, _timerCallback);

    _keySubject.add(newValue);
    _remainingTimeSubject.add(getRemainingTime());
    // console(ConsoleLevel.Info, "Total minutes: $_totalDuration Elapsed minutes: ${_timer.tick.toString()}");
  }

  void removeKey() {
    if (_timer != null && _timer.isActive) {
      resetRemainingTime();
    }
  }
}
