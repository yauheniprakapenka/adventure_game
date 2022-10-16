import 'dart:async';

class NinjaBoyIdleDirectionTimer {
  late Timer _timer;
  static const int _initialCouterValue = 0;

  int _count = _initialCouterValue;
  final int _maxCount = 3;

  bool get isFinished => _count >= _maxCount;

  void start() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _count++;
      },
    );
  }

  void stop() {
    _timer.cancel();
    _count = _initialCouterValue;
  }
}
