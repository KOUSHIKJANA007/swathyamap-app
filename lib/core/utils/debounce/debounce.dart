import 'dart:async';
import 'dart:ui';

class Debounce {
  Debounce({required this.milliseconds});
  final int milliseconds;

  Timer? _timer;

  /// Call this instead of your real callback
  void run(VoidCallback action) {
    _timer?.cancel();                 // cancel previous timer
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}