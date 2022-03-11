import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fourty_mom_project/controller/date_controller.dart';
import 'package:fourty_mom_project/controller/rwl_controller.dart';
import 'package:fourty_mom_project/controller/welcome_text_controller.dart';
import 'package:fourty_mom_project/utilities/router.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RWLController>(
            create: (context) => RWLController()),
        ChangeNotifierProvider<DateController>(
            create: (context) => DateController()),
        ChangeNotifierProvider<WelcomeTextController>(
            create: (context) => WelcomeTextController(true)),
      ],
      child: MaterialApp.router(
          //scrollBehavior: MyBehavior(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          /*[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],*/
          supportedLocales: AppLocalizations.supportedLocales,
          /*const [
            Locale('ko', ''),
            Locale('en', '')
          ],*/
          debugShowCheckedModeBanner: false,
          routeInformationParser: MyRouter().value.routeInformationParser,
          routerDelegate: MyRouter().value.routerDelegate),
    );
  }
}
