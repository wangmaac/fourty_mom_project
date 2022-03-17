import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/classes/firebase_class.dart';
import 'package:fourty_mom_project/controller/date_controller.dart';
import 'package:provider/provider.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  var _selectedTest;
  var _selectedHour;
  var _selectedMinutes;

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];

  final List _testList = [
    {'no': 1, 'keyword': 'Reading'},
    {'no': 2, 'keyword': 'Watching'},
    {'no': 3, 'keyword': 'Listening'}
  ];

  List<DropdownMenuItem<Object?>> _dropdownHourItems = [];

  final List _hourList = [
    {'no': 0, 'keyword': '0'},
    {'no': 1, 'keyword': '1'},
    {'no': 2, 'keyword': '2'},
    {'no': 3, 'keyword': '3'},
    {'no': 4, 'keyword': '4'},
    {'no': 5, 'keyword': '5'},
    {'no': 6, 'keyword': '6'},
    {'no': 7, 'keyword': '7'},
    {'no': 8, 'keyword': '8'},
    {'no': 9, 'keyword': '9'},
    {'no': 10, 'keyword': '10'},
    {'no': 11, 'keyword': '11'},
    {'no': 12, 'keyword': '12'},
  ];

  List<DropdownMenuItem<Object?>> _dropdownMinutesItems = [];

  final List _minutesList = [
    {'no': 0, 'keyword': '0'},
    {'no': 1, 'keyword': '5'},
    {'no': 2, 'keyword': '10'},
    {'no': 3, 'keyword': '15'},
    {'no': 4, 'keyword': '20'},
    {'no': 5, 'keyword': '25'},
    {'no': 6, 'keyword': '30'},
    {'no': 7, 'keyword': '35'},
    {'no': 8, 'keyword': '40'},
    {'no': 9, 'keyword': '45'},
    {'no': 10, 'keyword': '50'},
    {'no': 11, 'keyword': '55'},
    {'no': 12, 'keyword': '60'},
  ];

  late TextEditingController _textEditingController;
  late FocusNode _textFocus;
  late FirebaseMethod _firebaseMethod;

  @override
  void initState() {
    _firebaseMethod = FirebaseMethod();
    _firebaseMethod.initFirestore();

    _dropdownTestItems = buildDropdownTestItems(_testList);
    _dropdownHourItems = buildDropdownTestItems(_hourList);
    _dropdownMinutesItems = buildDropdownTestItems(_minutesList);

    _textEditingController = TextEditingController();
    _textFocus = FocusNode();
    super.initState();
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Object?>> buildDropdownHourItems(List _hourList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _hourList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Object?>> buildDropdownMinutesItems(List _minutesList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _minutesList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DropdownBelow(
          dropdownColor: Colors.pink.withOpacity(1),
          isDense: true,
          itemWidth: 200,
          itemTextstyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          boxTextstyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          boxPadding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
          //boxWidth: 200,
          boxHeight: 45,
          boxDecoration: BoxDecoration(
              color: Colors.amberAccent,
              border: Border.all(width: 1, color: Colors.white54)),
          icon: const FaIcon(
            FontAwesomeIcons.paw,
            size: 15.0,
            color: Colors.black,
          ),
          hint: const Text('Choose category'),
          value: _selectedTest,
          items: _dropdownTestItems,
          onChanged: onChangeDropdownTests,
        ),
        const SizedBox(height: 10),
        /**
         * 시간 : 분 Row()
         */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// todo 시간
            SizedBox(
              width: 45,
              child: DropdownBelow(
                //dropdownColor: Colors.black38,
                //isDense: true,
                itemWidth: 50,
                itemTextstyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                boxTextstyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                boxPadding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
                //boxWidth: 200,
                boxHeight: 45,
                boxDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black)),
                hint: FittedBox(
                  fit: BoxFit.fill,
                  child: FaIcon(
                    FontAwesomeIcons.clock,
                  ),
                ),
                value: _selectedHour,
                items: _dropdownHourItems,
                onChanged: onChangeDropdownHours,
              ),
            ),
            SizedBox(width: 3),
            Text('시간'),
            SizedBox(width: 10),

            /// todo 분
            SizedBox(
              width: 50,
              child: DropdownBelow(
                itemWidth: 55,
                itemTextstyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                boxTextstyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                boxPadding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
                //boxWidth: 200,
                boxHeight: 45,
                boxDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.black)),
                hint: FittedBox(
                  fit: BoxFit.fill,
                  child: FaIcon(
                    FontAwesomeIcons.clock,
                  ),
                ),
                value: _selectedMinutes,
                items: _dropdownMinutesItems,
                onChanged: onChangeDropdownMinutes,
              ),
            ),
            SizedBox(width: 3),
            const Text('분'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: TextField(
          focusNode: _textFocus,
          controller: _textEditingController,
          keyboardType: TextInputType.multiline,
          maxLines: 100,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0))),
        )),
        const SizedBox(
          height: 8,
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: Colors.black),
                backgroundColor: Colors.black),
            onPressed: () {
              confirmSave();
            },
            child: const SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  child: Text(
                    'save',
                  ),
                ),
              ),
              width: double.infinity,
              height: 45,
            )),
      ],
    ));
  }

  onChangeDropdownTests(selectedTest) {
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  onChangeDropdownHours(selectedHour) {
    setState(() {
      _selectedHour = selectedHour;
    });
  }

  onChangeDropdownMinutes(selectedMinutes) {
    setState(() {
      _selectedMinutes = selectedMinutes;
    });
  }

  Future confirmSave() async {
    int _hour = _selectedHour == null ? 0 : int.parse(_selectedHour['keyword']);
    int _minutes =
        _selectedMinutes == null ? 0 : int.parse(_selectedMinutes['keyword']);
    int _wholeDuration = (_hour * 60) + _minutes;

    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('please write contents'),
        duration: Duration(milliseconds: 800),
      ));
      FocusScope.of(context).requestFocus(_textFocus);
    } else if (_selectedTest == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('choose category'),
        duration: Duration(milliseconds: 800),
      ));
      FocusScope.of(context).requestFocus(_textFocus);
    } else if ((_hour * 60 + _minutes) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('choose duration'),
        duration: Duration(milliseconds: 800),
      ));
    } else {
      loadingAlertDialog();
      await _firebaseMethod.setFirestoreUser();
      if (_selectedTest['no'] == 1) {
        await _firebaseMethod.setFirestoreReading(_textEditingController.text,
            context.read<DateController>().getSelectDate, _wholeDuration);
        _textEditingController.clear();
        Navigator.of(context).pop();
      } else if (_selectedTest['no'] == 2) {
        await _firebaseMethod.setFirestoreWatching(_textEditingController.text,
            context.read<DateController>().getSelectDate, _wholeDuration);
        _textEditingController.clear();
        Navigator.of(context).pop();
      } else {
        await _firebaseMethod.setFirestoreListening(_textEditingController.text,
            context.read<DateController>().getSelectDate, _wholeDuration);
        _textEditingController.clear();
        Navigator.of(context).pop();
      }
    }
  }

  void loadingAlertDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('작성한 내용을 저장하고있습니다.'),
          );
        });
  }
}
