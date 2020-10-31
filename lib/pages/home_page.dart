import 'package:flutter/material.dart';
import 'package:Face_recognition/widgets/home_background.dart';
import 'package:Face_recognition/widgets/home_backdrop_filter.dart';
import 'package:Face_recognition/widgets/rooms_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const HomeBackground(),
          const HomeBackdropFilter(
            child: RoomsList(),
          )
        ],
      ),
    ));
  }
}
