import 'package:flutter/material.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/timeline_calendar.dart';

import '../widget/rail_and_container.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: const [
          SizedBox(height: 20),
          Expanded(child: RailContainer()),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            child: TimeLinePage(),
          ),
        ],
      ),
    );
  }
}
