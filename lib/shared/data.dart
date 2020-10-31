import 'models.dart';

class AppData {
  static List<Room> rooms = [
    Room(
        id: 1,
        name: 'Living Room',
        image: 'assets/images/living_room.jpg',
        devicesCount: 2),
    Room(
        id: 2,
        name: 'Bedroom',
        image: 'assets/images/bedroom.jpg',
        devicesCount: 2),
    Room(
        id: 3,
        name: 'Kitchen',
        image: 'assets/images/kitchen.jpg',
        devicesCount: 2),
    Room(
        id: 4,
        name: 'Outdoors',
        image: 'assets/images/outdoor.jpg',
        devicesCount: 1),
  ];
}
