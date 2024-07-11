import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<String> {
  TimerNotifier() : super("00:60") {
    _startTimer();
  }

  Timer? _timer;
  int _totalSeconds =
      60; // Initial value for the timer (60 seconds)

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_totalSeconds > 0) {
        _totalSeconds--;
        _updateTime();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _updateTime() {
    int minutes = _totalSeconds ~/ 60;
    int seconds = _totalSeconds % 60;
    state =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void resetTimer() {
    _timer?.cancel();
    _totalSeconds = 60; // Reset to 4 minutes and 30 seconds
    _updateTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, String>((ref) {
  return TimerNotifier();
});
