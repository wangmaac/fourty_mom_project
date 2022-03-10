import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_testList);
    _textEditingController = TextEditingController();
    print('write initState');
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
    print('write dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DropdownBelow(
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
            onPressed: () {},
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
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }
}
