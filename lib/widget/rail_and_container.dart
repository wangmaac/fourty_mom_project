import 'package:flutter/material.dart';
import 'package:fourty_mom_project/controller/rwl_controller.dart';
import 'package:fourty_mom_project/screens/entire_page.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:provider/provider.dart';

import '../utilities/rail_data.dart';

class RailContainer extends StatefulWidget {
  const RailContainer({Key? key}) : super(key: key);

  @override
  State<RailContainer> createState() => _RailContainerState();
}

class _RailContainerState extends State<RailContainer> {
/*  late RWLController _rwlController;
  late DateController _dateController;*/

  @override
  void didChangeDependencies() {
    /*_rwlController = Provider.of<RWLController>(context);
    _dateController = Provider.of<DateController>(context);*/
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          NavigationRail(
              groupAlignment: 0.0,
              selectedIndex: context.watch<RWLController>().getRWL,
              onDestinationSelected: (int index) {
                context.read<RWLController>().setRWL(index);
              },
              labelType: NavigationRailLabelType.selected,
              selectedLabelTextStyle: const TextStyle(color: Colors.black),
              destinations: destination),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const EntirePage()),
          )
        ],
      ),
    );
  }
}
