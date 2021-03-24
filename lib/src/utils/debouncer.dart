import 'dart:async';

/// A debounce function completely halts function calls
/// until the call rate of the function falls low enough
class Debouncer {
  /// debouncer delay
  final Duration delay;

  /// debouncer timer
  Timer? _timer;

  /// default constructor
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// run the function
  run(Function action, {Duration? delay}) {
    _timer?.cancel();
    _timer = Timer(delay ?? this.delay, action as void Function());
  }
}
