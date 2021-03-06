import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourty_mom_project/controller/date_controller.dart';
import 'package:fourty_mom_project/controller/welcome_text_controller.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/tabbar_widget.dart';
import 'package:provider/provider.dart';

import '../utilities/date_format.dart';
import '../utilities/tab_data.dart';
import 'drawer_page.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late FirebaseAuth _firebaseAuth;

  late FocusScopeNode currentFocus;

  DateTime? backButtonPressedTime;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _tabController = TabController(length: TabPairs.length, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    currentFocus = FocusScope.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            key: _key,
            drawerEnableOpenDragGesture: true,
            drawer: const DrawerPage(),
            backgroundColor: backgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, minHeight: double.infinity),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 20),
                      child: DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.grey),
                          child: Text(dateFormat.format(
                              context.watch<DateController>().getSelectDate))),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, right: 10),
                      child: DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                          child: howTextWidget(_firebaseAuth.currentUser!)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              _firebaseAuth.currentUser!.photoURL!),
                          maxRadius: 20,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: SafeArea(
                child: myTabBar(_tabController, currentFocus, context))),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) >
            const Duration(seconds: 2);
    if (backButton) {
      backButtonPressedTime = currentTime;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('2??? ????????? ??????')));
      return false;
    }
    return true;
  }

  Widget howTextWidget(User user) {
    if (context.watch<WelcomeTextController>().getShow) {
      return AnimatedTextKit(
        key: const ValueKey(1),
        animatedTexts: [
          FadeAnimatedText(
            '???????????????. ${user.displayName}???',
          ),
          FadeAnimatedText('???????????? ???????????????.'),
        ],
        pause: const Duration(milliseconds: 1000),
        isRepeatingAnimation: false,
        onFinished: () {
          Provider.of<WelcomeTextController>(context, listen: false)
              .setShowEntireText(false);
        },
      );
    } else {
      return AnimatedTextKit(
        key: const ValueKey(2),
        animatedTexts: [
          WavyAnimatedText(
            '${user.displayName}???',
            speed: const Duration(milliseconds: 500),
          ),
        ],
        pause: const Duration(milliseconds: 1000),
        totalRepeatCount: 1,
        isRepeatingAnimation: true,
        //repeatForever: true,
      );
    }
  }
}
