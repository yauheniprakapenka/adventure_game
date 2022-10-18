import 'dart:async';

class NinjaBoyIdleDirectionTimer {
  late Timer _timer;
  
  static const int _initialCouterValue = 0;
  static const int _maxCount = 2;

  int _count = _initialCouterValue;
  bool _isInitialized = false;

  bool get isFinished => _count >= _maxCount;
  bool get isInitialezed => _isInitialized;

  void start() {
    _isInitialized = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _count++;
      },
    );
  }

  void stop() {
    if (isInitialezed) {
      _isInitialized = false;
      _timer.cancel();
    }
  }

  void reset() {
    if (isInitialezed) {
      stop();
      _count = _initialCouterValue;
    }
  }
}
