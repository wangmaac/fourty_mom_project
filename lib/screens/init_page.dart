import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fourty_mom_project/controller/date_controller.dart';
import 'package:fourty_mom_project/controller/localization_controller.dart';
import 'package:fourty_mom_project/controller/welcome_text_controller.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/tabbar_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../utilities/date_format.dart';
import '../utilities/tab_data.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late FocusScopeNode currentFocus;

  DateTime? backButtonPressedTime;

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
    print(context.watch<MyLocalizationController>().getLocale);

    return GestureDetector(
      onTap: () {
        if (currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
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
                    Spacer(),
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
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  content: const Text('로그아웃'),
                                  actions: [
                                    OutlinedButton(
                                      child: const Text(
                                        'yes',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _googleSignIn.signOut();
                                        _firebaseAuth.signOut();
                                        FacebookAuth.instance.logOut();
                                      },
                                    ),
                                    OutlinedButton(
                                      child: const Text(
                                        'no',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    )
                                  ],
                                );
                              });
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
          .showSnackBar(const SnackBar(content: Text('2번 누르면 종료')));
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
            '반갑습니다. ${user.displayName}님',
          ),
          FadeAnimatedText('매일매일 응원합니다.'),
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
            '${user.displayName}님',
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
