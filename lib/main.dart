import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'routes.dart';
import 'theme.dart';

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    final List<Frame> frames = Trace.current().frames;
    try {
      final Frame f = frames.skip(0).firstWhere((Frame f) =>
          f.library.toLowerCase().contains(rec.loggerName.toLowerCase()) &&
          f != frames.first);
      print(
          '${rec.level.name}: ${f.member} (${rec.loggerName}:${f.line}): ${rec.message}');
    } catch (e) {
      print(e.toString());
    }
  });
}

void main() {
  initLogger();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/',
      onGenerateRoute: Routes.builder(),
    );
  }
}
