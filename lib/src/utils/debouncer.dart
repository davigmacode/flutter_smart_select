import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer _timer;

  Debouncer({
    this.delay = const Duration(milliseconds: 300)
  });

  run(Function action, { Duration delay }) {
    _timer?.cancel();
    _timer = Timer(delay ?? this.delay, action);
  }
}