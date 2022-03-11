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
  ValueKey dropdownKey1 = const ValueKey(1001);

  var _selectedTest;

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  final List _testList = [
    {'no': 1, 'keyword': 'Reading'},
    {'no': 2, 'keyword': 'Watching'},
    {'no': 3, 'keyword': 'Listening'}
  ];

  late TextEditingController _textEditingController;
  late FocusNode _textFocus;
  late FirebaseMethod _firebaseMethod;

  @override
  void initState() {
    _firebaseMethod = FirebaseMethod();
    _firebaseMethod.initFirestore();
    _dropdownTestItems = buildDropdownTestItems(_testList);
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
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
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
        /*const SizedBox(height: 100),*/
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: Colors.black),
                backgroundColor: Colors.black),
            onPressed: () {
              confirm();
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
            ))
      ],
    ));
  }

  onChangeDropdownTests(selectedTest) {
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  Future confirm() async {
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
    } else {
      await _firebaseMethod.setFirestoreUser();
      if (_selectedTest['no'] == 1) {
        await _firebaseMethod.setFirestoreReading(_textEditingController.text,
            context.read<DateController>().getSelectDate);
        _textEditingController.clear();
      } else if (_selectedTest['no'] == 2) {
        await _firebaseMethod.setFirestoreWatching(_textEditingController.text,
            context.read<DateController>().getSelectDate);
        _textEditingController.clear();
      } else {
        await _firebaseMethod.setFirestoreListening(_textEditingController.text,
            context.read<DateController>().getSelectDate);
        _textEditingController.clear();
      }
    }
    _firebaseMethod.getFirestoreReading();
  }
}
