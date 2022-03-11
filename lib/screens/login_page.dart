import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fourty_mom_project/classes/facebook_login_class.dart';
import 'package:fourty_mom_project/classes/firebase_class.dart';
import 'package:fourty_mom_project/classes/google_login_class.dart';
import 'package:fourty_mom_project/screens/init_page.dart';

import '../utilities/logger.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return Scaffold(
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
                  ],
                ),
              );
            } else {
              logger.d(AppLocalizations.of(context)!.appTitle);
              logger.d(AppLocalizations.of(context)!.localeName);
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
