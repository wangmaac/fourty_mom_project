import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fourty_mom_project/classes/facebook_login_class.dart';
import 'package:fourty_mom_project/classes/firebase_class.dart';
import 'package:fourty_mom_project/classes/google_login_class.dart';
import 'package:fourty_mom_project/screens/init_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _initialized = false;
  late GoogleMethod _googleMethod;
  late FaceBookMethod _faceBookMethod;
  late FirebaseMethod _firebaseMethod;
  late bool _clicked;

  final List<BoxShadow> effectShadow = [
    BoxShadow(
        offset: Offset(16, 16),
        color: Colors.black38,
        blurRadius: 16,
        spreadRadius: 2),
    BoxShadow(
      offset: Offset(-16, -16),
      blurRadius: 16,
      spreadRadius: 2,
      color: Colors.white,
    )
  ];

  final List<BoxShadow> unEffectShadow = [];

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _googleMethod = GoogleMethod();
    _faceBookMethod = FaceBookMethod();
    _firebaseMethod = FirebaseMethod();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _firebaseMethod.initializeFlutterFire().then((init) {
      setState(() {
        _initialized = init;
      });
    });
    _clicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _googleMethod.signInWithGoogle();
                      },
                      child: const Text('google login button'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _faceBookMethod.signInWithFacebook();
                      },
                      child: const Text('facebook login button'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Center(
                          child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 45,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(16, 16),
                                color: Colors.black38,
                                blurRadius: 16,
                                spreadRadius: 2),
                            BoxShadow(
                              offset: Offset(-16, -16),
                              blurRadius: 16,
                              spreadRadius: 2,
                              color: Colors.white,
                            )
                          ],
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 100,
                        height: 100,
                        child: Center(
                            child: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 45,
                        )),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: _clicked ? unEffectShadow : effectShadow,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const InitPage();
            }
          },
        ),
      );
    } else {
      return const CircularProgressIndicator.adaptive();
    }
  }
}
