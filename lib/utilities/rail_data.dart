import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/utilities/icon_data.dart';

List<NavigationRailDestination> destination = [
  const NavigationRailDestination(
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
    selectedIcon: readingIcon(30, true),
    icon: readingIcon(30, false),
    label: const Text('Reading'),
  ),
  NavigationRailDestination(
    selectedIcon: videoIcon(30, true),
    icon: videoIcon(30, false),
    label: const Text('Video'),
  ),
  NavigationRailDestination(
    selectedIcon: listeningIcon(30, true),
    icon: listeningIcon(30, false),
    label: const Text('Listening'),
  ),
];
