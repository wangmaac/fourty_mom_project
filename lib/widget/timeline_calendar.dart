import 'package:flutter/material.dart';
import 'package:fourty_mom_project/controller/date_controller.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../utilities/color.dart';
import '../utilities/date_format.dart';
import '../utilities/logger.dart';
import '../utilities/scroll_behavior.dart';
import '../utilities/scroll_controller.dart';
import 'timeline_content_widget.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  late DateController _dateController;

  @override
  void initState() {
    super.initState();
  }

  _scrollToIndex(index) async {
    await autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);
  }

  @override
  void didChangeDependencies() {
    _dateController = Provider.of<DateController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: timeLineItemCount,
                scrollDirection: Axis.horizontal,
                controller: autoScrollController,
                itemBuilder: (BuildContext context, int index) {
                  DateTime itemDate = DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day)
                      .subtract(Duration(days: index));
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: autoScrollController,
                    index: index,
                    child: context.watch<DateController>().getSelectDate ==
                            itemDate
                        ? selectBox(
                            child: selectContent(itemDate),
                            color: selectIconColor,
                            index: index)
                        : unSelectBox(
                            index: index, child: unSelectContent(itemDate)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectBox({Widget? child, Color? color, required int index}) {
    return roundRectangleContainer(
        color: color, width: 100, child: child, index: index);
  }

  Widget unSelectBox({Widget? child, Color? color, required int index}) {
    return roundRectangleContainer(
        color: color, child: child, width: 100, index: index);
  }

  /*
    Todo Common Container shape
  */

  Widget roundRectangleContainer(
      {double? width, Color? color, Widget? child, required int index}) {
    return GestureDetector(
      onTap: () async {
        _scrollToIndex(index);
        _dateController.setSelectDate(
            _dateController.getBaseDate.subtract(Duration(days: index)));
      },
      child: Container(
        width: width,
        child: child,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: color ??= Colors.grey),
          //    color: color ??= Colors.white
        ),
      ),
    );
  }
}
