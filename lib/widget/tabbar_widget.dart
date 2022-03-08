import 'package:flutter/material.dart';

import '../utilities/color.dart';
import '../utilities/tab_data.dart';

Widget myTabBar(TabController _tabController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
// give the tab bar a height [can change height to preferred height]
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: TabBar(
                controller: _tabController,
// give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.black,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: TabPairs.map((tabPair) => tabPair.tab).toList()),
          ),
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: TabPairs.map((tabPair) => tabPair.view).toList()),
        ),
      ],
    ),
  );
}
