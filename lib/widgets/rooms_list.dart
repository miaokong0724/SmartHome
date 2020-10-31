import 'package:Face_recognition/shared/data.dart';
import 'package:Face_recognition/shared/models.dart';
import 'package:Face_recognition/shared/store.dart';
import 'package:flutter/material.dart';

import 'room_card/room_card.dart';

class RoomsList extends StatefulWidget {
  const RoomsList({Key key}) : super(key: key);

  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  PageController _controller;
  int currentPage = 0;
  List<Room> rooms = AppData.rooms;
  Store _store = Store();

  @override
  void initState() {
    super.initState();

    _controller = PageController(viewportFraction: 0.9);
    _controller.addListener(() {
      int next = _controller.page.round();

      if (currentPage != next) {
        _onChangePage(next);
      }
    });
  }

  _onChangePage(int page) {
    setState(() {
      currentPage = page;
    });
    _store.onRoomChange(page);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: PageView.builder(
        controller: _controller,
        itemCount: rooms.length,
        physics: BouncingScrollPhysics(),
        onPageChanged: (int page) {
          _onChangePage(page);
        },
        itemBuilder: (BuildContext context, int index) {
          bool isActive = index == currentPage;
          return (index != 4)
              ? RoomCard(page: index, room: rooms[index], isActive: isActive)
              : RoomCard(
                  page: index,
                  room: rooms[index],
                  isActive: isActive,
                  isOutdoor: true,
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _store.roomsController.close();
    _store.roomController.close();
  }
}
