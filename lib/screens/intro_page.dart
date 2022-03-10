import 'package:flutter/material.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/rail_and_container.dart';

import '../widget/timeline_calendar.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Column(
        children: const [
          SizedBox(height: 10),
          Expanded(child: RailContainer()),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: TimeLinePage(),
          ),
        ],
      ),
    );
  }
}
