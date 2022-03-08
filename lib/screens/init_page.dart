import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fourty_mom_project/utilities/color.dart';
import 'package:fourty_mom_project/widget/tabbar_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                    padding: const EdgeInsets.only(right: 10.0, bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                content: const Text('LOGOUT?'),
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
