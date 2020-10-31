/// Library wide logging class
class AppLogger {
  bool loggingOn;
  AppLogger(bool loggingOn) {
    this.loggingOn = loggingOn;
  }

  void log(String message) {
    if (this.loggingOn) {
      final DateTime now = DateTime.now();
      print('$now -- $message');
    }
  }

  void logging({bool on = false}) {
    this.loggingOn = on;
  }
}
