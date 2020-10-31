import 'dart:async';
import 'package:logging/logging.dart';

class AdafruitFeed {
  static var _feedController = StreamController<String>();
  static Stream<String> get sensorStream => _feedController.stream;

  static void add(String value) {
    Logger log = Logger('Adafruit_feed.dart');
    try {
      _feedController.add(value);
      log.info('---> added value to the Stream... the value is: $value');
    } catch (e) {
      log.severe(
          '$value was published to the feed.  Error adding to the Stream: $e');
    }
  }
}
