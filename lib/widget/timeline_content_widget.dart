import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/utilities/date_format.dart';

import '../models/record_model.dart';

Widget selectContent(DateTime itemDate) {
  List<Map<String, dynamic>> result = [];

  result =
      List.of(tmpListModel.where((element) => itemDate == element['date']));

  FaIcon notStudyIcon = const FaIcon(
    FontAwesomeIcons.ban,
    color: Colors.white,
  );

  if (result.isNotEmpty) {
    Widget subIconList = SizedBox(
        width: 85,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          result.first['book'] == null
              ? notStudyIcon
              : const ImageIcon(
                  AssetImage('images/icons/book_icon.png'),
                  size: 25,
                  color: Colors.black,
                ),
          result.first['video'] == null
              ? notStudyIcon
              : const ImageIcon(
                  AssetImage('images/icons/video_icon.png'),
                  size: 25,
                  color: Colors.black,
                ),
          result.first['listen'] == null
              ? ImageIcon(
                  const AssetImage('images/icons/music_icon.png'),
                  size: 25,
                  color: Colors.grey.shade200,
                )
              : const ImageIcon(
                  AssetImage('images/icons/music_icon.png'),
                  size: 25,
                  color: Colors.black,
                ),
        ]));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateFormat.format(result.first['date']),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        subIconList
      ],
    );
  } else {
    /*if (itemDate == 7 || itemDate == 6) {
      localColor = Colors.red;
    }*/
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
