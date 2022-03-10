import 'package:flutter/material.dart';

import '../screens/intro_page.dart';
import '../screens/write_page.dart';

class TabPair {
  final Tab tab;
  final Widget view;
  TabPair({required this.tab, required this.view});
}

List<TabPair> TabPairs = [
  TabPair(
      tab: const Tab(
        text: 'Intro',
      ),
      view: IntroPage()),
  TabPair(
    tab: Tab(
      text: '쓰기',
    ),
    view: Center(
        // replace with your own widget here
        child: WritePage()),
  ),
  TabPair(
    tab: Tab(
      text: '통계',
    ),
    view: Center(
      child: Text(
        '통계 페이지',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  )
];
