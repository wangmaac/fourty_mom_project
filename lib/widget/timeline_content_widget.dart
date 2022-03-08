import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/utilities/date_format.dart';

import '../models/record_model.dart';
import '../utilities/logger.dart';

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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          result.first['book'] == null
              ? notStudyIcon
              : const FaIcon(
                  FontAwesomeIcons.bookOpen,
                  color: Colors.white,
                ),
          result.first['video'] == null
              ? notStudyIcon
              : const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.white,
                ),
          result.first['listen'] == null
              ? notStudyIcon
              : const FaIcon(FontAwesomeIcons.earlybirds, color: Colors.white),
        ]));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateFormat.format(result.first['date']),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        subIconList
      ],
    );
  } else {
    return Center(
      child: Text(
        dateFormat.format(itemDate),
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
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
    return Center(
      child: Text(
        dateFormat.format(itemDate),
        style: TextStyle(fontWeight: FontWeight.bold, color: _backColor),
      ),
    );
  }
}
