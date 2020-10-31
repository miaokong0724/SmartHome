import 'package:flutter/material.dart';
import 'package:Face_recognition/camera/camera_home.dart';
import 'package:Face_recognition/shared/models.dart';
import 'package:Face_recognition/shared/animations.dart';
import 'package:Face_recognition/widgets/room_background_image.dart';
import 'package:Face_recognition/widgets/room_heading.dart';
import 'package:Face_recognition/widgets/room_details/device.dart';
import 'package:Face_recognition/widgets/room_details/music_player.dart';
import 'package:Face_recognition/widgets/room_details/device_controller.dart';
import 'package:Face_recognition/widgets/room_details/air_conditioner_controller.dart';
import 'package:Face_recognition/utilities/mqtt_stream.dart';
// import 'package:Face_recognition/utilities/Adafruit_feed.dart';

class RoomDetailsPage extends StatefulWidget {
  final Room room;
  final bool isOutdoor;
  RoomDetailsPage({
    this.room,
    this.isOutdoor = false,
  });

  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _animationController;
  RoomDetailsEnterAnimations _enterAnimations;
  bool _status = false;
  bool lastStatus = true;
  double appBarHeight = 200.0;

  AppMqttTransactions myMqtt = AppMqttTransactions();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _animationController =
        AnimationController(duration: Duration(milliseconds: 2000), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.dismissed) {
              Navigator.of(context).pop();
            }
          });
    _enterAnimations = RoomDetailsEnterAnimations(_animationController);
    _animationController.forward();
  }

  void subscribe(String topic) {
    myMqtt.subscribe(topic);
  }

  void publish(String topic, String value) {
    myMqtt.publish(topic, value);
  }

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (appBarHeight - 110);
  }

  Widget _buildDevicePlayerRow() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Transform.translate(
            offset: Offset(0.0, _enterAnimations.deviceTranslation.value),
            child: Container(
              padding: EdgeInsets.only(right: 6.0),
              child: Device(
                name: 'LAMP',
                status: _status,
                image: 'assets/images/lamp_icon.png',
                heading: 'LED',
                subHeading: '',
                onTap: () {
                  setState(() {
                    _status = !_status;
                    // print(_status);
                    publish(
                        "vkmanojk/feeds/smart-home", (_status) ? "ON" : "OFF");
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Transform.translate(
            offset: Offset(0.0, _enterAnimations.playerTranslation.value),
            child: Container(
              padding: EdgeInsets.only(left: 6.0),
              child: const MusicPlayer(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDeviceController() {
    return (widget.room.id == 4 || widget.room.id == 3)
        ? Container()
        : Transform.translate(
            offset:
                Offset(_enterAnimations.deviceControllerTranslation.value, 0.0),
            child: const DeviceController(
              status: true,
              heading: 'LAMP',
              subHeading: '',
            ),
          );
  }

  Widget _buildAirConditionerController() {
    return (widget.room.id == 4)
        ? Container()
        : Transform.translate(
            offset:
                Offset(_enterAnimations.airControllerTranslation.value, 0.0),
            child: const AirConditionerController(),
          );
  }

  Widget _buildCameraController() {
    // print(widget.room.id);
    return (widget.room.id == 4)
        ? Transform.translate(
            offset:
                Offset(_enterAnimations.deviceControllerTranslation.value, 0.0),
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.lock,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraPage()));
                },
              ),
            ),
          )
        : Container();
  }

  Widget _buildSliverList() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
          child: Column(
            children: <Widget>[
              _buildDevicePlayerRow(),
              const SizedBox(height: 25.0),
              _buildDeviceController(),
              const SizedBox(height: 25.0),
              _buildAirConditionerController(),
              const SizedBox(height: 25.0),
              _buildCameraController()
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _animationController.reverse();
      },
      child: Scaffold(
        body: RoomBackgroundImage(
          id: widget.room.id,
          name: widget.room.name,
          image: widget.room.image,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    leading: AnimatedBuilder(
                      animation: _animationController,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            _animationController.reverse();
                          }),
                      builder: (BuildContext context, Widget child) {
                        return Transform.translate(
                          offset:
                              Offset(_enterAnimations.backButton.value, 0.0),
                          child: child,
                        );
                      },
                    ),
                    expandedHeight: 200.0,
                    forceElevated: false,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: isShrink ? 30.0 : 120.0,
                        child:
                            RoomHeading(name: widget.room.name, fontSize: 23.0),
                      ),
                    )),
                SliverList(
                  delegate:
                      SliverChildListDelegate(<Widget>[_buildSliverList()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _animationController.dispose();
  }
}
