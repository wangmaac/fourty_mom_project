import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<NavigationRailDestination> destination = const [
  NavigationRailDestination(
    selectedIcon: FaIcon(
      FontAwesomeIcons.kissWinkHeart,
      color: Colors.black,
      size: 30,
    ),
    icon: FaIcon(
      FontAwesomeIcons.kiss,
      color: Colors.grey,
    ),
    label: Text(
      'Entire',
    ),
  ),
  NavigationRailDestination(
    selectedIcon: ImageIcon(
      AssetImage('images/icons/book_icon.png'),
      size: 30,
      color: Colors.black,
    ),
    icon: ImageIcon(
      AssetImage('images/icons/book_icon.png'),
      size: 30,
      color: Colors.grey,
    ),
    label: Text(
      'Reading',
    ),
  ),
  NavigationRailDestination(
    selectedIcon: ImageIcon(
      AssetImage('images/icons/video_icon.png'),
      size: 30,
      color: Colors.black,
    ),
    icon: ImageIcon(
      AssetImage('images/icons/video_icon.png'),
      size: 30,
      color: Colors.grey,
    ),
    label: Text(
      'Video',
    ),
  ),
  NavigationRailDestination(
    selectedIcon: ImageIcon(
      AssetImage('images/icons/music_icon.png'),
      size: 30,
      color: Colors.black,
    ),
    icon: ImageIcon(
      AssetImage('images/icons/music_icon.png'),
      size: 30,
      color: Colors.grey,
    ),
    label: Text(
      'Listening',
    ),
  ),
];
