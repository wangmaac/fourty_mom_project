import 'package:flutter/material.dart';
import 'package:fourty_mom_project/utilities/date_format.dart';

import '../models/record_model.dart';
import '../utilities/icon_data.dart';

//선택했을때
Widget calendarContent(DateTime itemDate) {
  List<Map<String, dynamic>> result = [];
  late Widget resultSubIconList;

  //선택한 json schedule
  result =
      List.of(tmpListModel.where((element) => itemDate == element['date']));

  if (result.isNotEmpty) {
    resultSubIconList = SizedBox(
        width: 80,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          result.first['book'] == null
              ? iconBorder()
              : iconBorder(child: readingIcon(20, true)),
          result.first['video'] == null
              ? iconBorder()
              : iconBorder(child: videoIcon(20, true)),
          result.first['listen'] == null
              ? iconBorder()
              : iconBorder(child: listeningIcon(20, true)),
        ]));
  } else {
    resultSubIconList = const SizedBox(width: 85);
  }

  return Column(
    children: [
      const SizedBox(height: 3),
      //todo 선택했을때 내용이 있으면 - 월 표시
      SizedBox(
        child: FittedBox(
            child: Text(
          mmmDateFormat.format(itemDate),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        height: 20,
      ),

      //todo 선택했을때 내용이 있으면 - 일자 표시
      Expanded(
          child: FittedBox(
              child: Text(
        itemDate.day.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: itemDate.weekday == 7
                ? Colors.red
                : itemDate.weekday == 6
                    ? Colors.blue
                    : Colors.black),
      ))),

      //todo 선택했을때 내용이 있으면 - 아이콘리스트 표시
      SizedBox(
        height: 20,
        child: resultSubIconList,
      ),

      //todo 선택했을때 내용이 있으면 - 요일 표시
      SizedBox(
        child: FittedBox(
          child: Text(
            mDateFormat.format(itemDate),
          ),
        ),
        height: 20,
      ),
      const SizedBox(height: 3),
    ],
  );
}

Widget iconBorder({Widget? child}) {
  if (child == null) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const SizedBox(width: 20, height: 20),
    );
  } else {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: child,
      ),
    );
  }
}
