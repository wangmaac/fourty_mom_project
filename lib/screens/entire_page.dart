import 'package:flutter/material.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:provider/provider.dart';

import '../controller/date_controller.dart';
import '../utilities/date_format.dart';

class EntirePage extends StatelessWidget {
  const EntirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          Center(
            child: Text(
              eDateFormat.format(context.watch<DateController>().getSelectDate),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
          /*Text(context.watch<RWLController>().getRWL.toString()),*/
          Text('Reading'),
          Text('title\n'),
          Text('Watching'),
          Text('title\n'),
          Text('Listening'),
          Text('title'),
        ],
      ),
    );
  }
}
