import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../controller/localization_controller.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool _expanded = false;

  late FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg'))),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(AppLocalizations.of(context)!.hello,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500))),
              ])),
          GestureDetector(
            onTap: () => showMyDialog(context),
            child: const ListTile(
              title: Text('로그아웃'),
            ),
          ),
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            children: [
              ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      height: 30,
                      child: const Text('언어변경'),
                    );
                  },
                  body: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Provider.of<MyLocalizationController>(context,
                                  listen: false)
                              .changeLocale('Korean');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Image.asset('images/kr.png'),
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child:
                                    Text(AppLocalizations.of(context)!.korean),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Image.asset('images/us.png'),
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(AppLocalizations.of(context)!.english),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Provider.of<MyLocalizationController>(context,
                                  listen: false)
                              .changeLocale('English');
                          //localController.changeLocale('en');
                        },
                      ),
                    ],
                  ),
                  isExpanded: _expanded),
            ],
            expansionCallback: (int, value) {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              title: Text('about 만든이'),
            ),
          ),
        ],
      ),
    );
  }

  showMyDialog(BuildContext context) {
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
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
