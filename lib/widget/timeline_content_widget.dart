import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/utilities/date_format.dart';

import '../models/record_model.dart';
import '../utilities/icon_data.dart';


//선택했을때
Widget selectContent(DateTime itemDate) {
  List<Map<String, dynamic>> result = [];

  result =
      List.of(tmpListModel.where((element) => itemDate == element['date']));

  if (result.isNotEmpty) {
    Widget subIconList = SizedBox(
        width: 85,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          result.first['book'] == null
              ? readingIcon(25, false)
              : readingIcon(25, true),
          result.first['video'] == null
              ? videoIcon(25, false)
              : videoIcon(25, true),
          result.first['listen'] == null
              ? listeningIcon(25, false)
              : listeningIcon(25, true),
        ]));
    return
      Column(
        children: [
          SizedBox(
            child: FittedBox(
                child: Text(
                  mmmDateFormat.format(itemDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            height: 20,
          ),
          Expanded(
              child: FittedBox(
                  child: Text(
                    itemDate.day.toString(),
                    style: TextStyle(
                        color: itemDate.weekday == 7
                            ? Colors.red
                            : itemDate.weekday == 6
                            ? Colors.blue
                            : Colors.black),
                  ))),
          SizedBox(height: 20,  child: subIconList,),
          SizedBox(
            child: FittedBox(
              child: Text(
                mDateFormat.format(itemDate),
              ),
            ),
            height: 20,
          ),
        ],
      );
  } else {
    return Column(
      children: [
        const SizedBox(height: 5,),
        SizedBox(
          child: FittedBox(
              child: Text(
            mmmDateFormat.format(itemDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          height: 20,
        ),
        Expanded(
            child: FittedBox(
                child: Text(
          itemDate.day.toString(),
          style: TextStyle(
              color: itemDate.weekday == 7
                  ? Colors.red
                  : itemDate.weekday == 6
                      ? Colors.blue
                      : Colors.black),
        ))),
        const SizedBox(height: 15,),
        SizedBox(
          child: FittedBox(
            child: Text(
              mDateFormat.format(itemDate),
            ),
          ),
          height: 20,
        ),
        const SizedBox(height: 5,),
      ],
    );
  }
}

Widget unSelectContent(DateTime itemDate) {
  Color _backColor = Colors.grey;

  List<Map<String, dynamic>> result = [];
  result =
      List.of(tmpListModel.where((element) => itemDate == element['date']));

  FaIcon notStudyIcon = const FaIcon(
    FontAwesomeIcons.ban,
    color: Colors.grey,
  );

  if (result.isNotEmpty) {
    Widget subIconList =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      result.first['book'] == null
          ? notStudyIcon
          : const FaIcon(
              FontAwesomeIcons.bookOpen,
              color: Colors.grey,
            ),
      result.first['video'] == null
          ? notStudyIcon
          : const FaIcon(
              FontAwesomeIcons.youtube,
              color: Colors.grey,
            ),
      result.first['listen'] == null
          ? notStudyIcon
          : const FaIcon(FontAwesomeIcons.earlybirds, color: Colors.grey),
    ]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateFormat.format(result.first['date']),
          style: TextStyle(fontWeight: FontWeight.bold, color: _backColor),
        ),
        subIconList
      ],
    );
  } else {
    return Column(
      children: [
        SizedBox(
          child: FittedBox(
              child: Text(
            mmmDateFormat.format(itemDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          height: 20,
        ),
        Expanded(
            child: FittedBox(
                child: Text(
          itemDate.day.toString(),
          style: TextStyle(
              color: itemDate.weekday == 7
                  ? Colors.red
                  : itemDate.weekday == 6
                      ? Colors.blue
                      : Colors.black),
        ))),
        SizedBox(
          child: FittedBox(
            child: Text(
              mDateFormat.format(itemDate),
            ),
          ),
          height: 20,
        ),
      ],
    );
  }
}
