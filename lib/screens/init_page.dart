import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/tabbar_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

  DateTime? backButtonPressedTime;

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _tabController = TabController(length: TabPairs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    return WillPopScope(
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
                    padding: const EdgeInsets.only(bottom:18.0, right: 10),
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText('반갑습니다.',),
                          FadeAnimatedText('${_firebaseAuth.currentUser!.displayName}님 '),
                          FadeAnimatedText('매일매일 작성하는게 제일 중요합니다.'),
                          WavyAnimatedText('${_firebaseAuth.currentUser!.displayName}님'),
                        ],
                        pause: const Duration(milliseconds: 500),
                        displayFullTextOnTap: true,

                        isRepeatingAnimation: false,

                      ),
                    ),
                  ),
                 /* AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('AWESOME'),
                      RotateAnimatedText('OPTIMISTIC'),
                      RotateAnimatedText(
                        'DIFFERENT',
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 10,
                  ),*/
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
                        backgroundImage:
                            NetworkImage(_firebaseAuth.currentUser!.photoURL!),
                        maxRadius: 20,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SafeArea(child: myTabBar(_tabController))),
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
          .showSnackBar(const SnackBar(content: Text('2번 누리면 종료')));
      return false;
    }
    return true;
  }
}
