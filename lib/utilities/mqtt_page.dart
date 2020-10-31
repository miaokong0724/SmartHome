import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class MqttPage extends StatefulWidget {
  MqttPage({this.title});
  final String title;

  @override
  MqttPageState createState() => MqttPageState();
}

class MqttPageState extends State<MqttPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: const Text("Get Time"),
            splashColor: Colors.blue,
            onPressed: () {
              _getTime(context);
            },
          ),
        ),
      ),
    );
  }
}

printString() async {
  String returnString = await returnAString();
  print('the string is --> $returnString');
}

Future<String> returnAString() {
  // (in the future...) after 6 seconds, the string 'hello there' will
  // be in the result var until then it is an "Instance of Future<String>"
  Future<String> result = Future.delayed(Duration(seconds: 5), () {
    return 'hello there';
  });
  return result;
}

Future<Map> _getBrokerAndKey(BuildContext context) async {
  String connect =
      await DefaultAssetBundle.of(context).loadString("config/private.json");
  return (json.decode(connect));
}

_getTime(BuildContext context) async {
  print("right before getConnectSTuff");
  Map connectJson = await _getBrokerAndKey(context);
  print('broker: ${connectJson['broker']}');
  print('key   : ${connectJson['key']}');

  print("right after getConnectStuff");
  printString();
}
