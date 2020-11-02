// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:Face_recognition/shared/styles.dart';
import '../gradient_box.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlay = false;
  int index = 0;
  List songs = [
    'Never Took the Time',
    'Ocean rings',
    'Bad guy',
    'She\'s crazy but she\'s mine',
  ];
  Widget selectIcon() {
    return (isPlay)
        ? IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 35.0,
            ),
            onPressed: () {
              setState(() {
                isPlay = !isPlay;
              });
            },
          )
        : IconButton(
            icon: Icon(
              Icons.pause,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              setState(() {
                isPlay = !isPlay;
              });
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBox(
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Text('NOW',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white54)),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Container(
              child: Material(
            color: Colors.transparent,
            child: Text('${songs[index]}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70)),
          )),
          Container(
              child: Material(
            color: Colors.transparent,
            child: Text('- AKON',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70)),
          )),
          SizedBox(height: 5.0),
          Material(
            color: Colors.transparent,
            child: Text('MK',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor)),
          ),
          SizedBox(height: 15.0),
          Material(
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous,
                      color: Colors.white, size: 15.0),
                  iconSize: 20,
                  padding: EdgeInsets.all(0),
                  onPressed: (index == 0)
                      ? null
                      : () {
                          setState(() {
                            index -= 1;
                          });
                        },
                ),
                selectIcon(),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white, size: 15.0),
                  iconSize: 10,
                  onPressed: (index == 3)
                      ? null
                      : () {
                          setState(() {
                            index += 1;
                          });
                        },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
