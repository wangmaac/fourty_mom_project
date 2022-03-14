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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(),
            Center(
              child: Text(
                eDateFormat
                    .format(context.watch<DateController>().getSelectDate),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ),
            /*Text(context.watch<RWLController>().getRWL.toString()),*/
            Text(
              '''         
<윤채>
  1. 책읽기
    -> 08:00~12:00(4시간)
    -> My friend Author #2
  2. 영상보기
    -> 14:00~18:00
    -> 넷플릭스 스파이더맨, 코코 외 
            
<채아>
  1. 책읽기
    -> 08:00~12:00(4시간)
    -> My friend Author #2
       My friend Author #3
       My friend Author #4
       My friend Author #5
  2. 영상보기
    -> 14:00~18:00
    -> 넷플릭스 스파이더맨, 코코 외
            ''',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
