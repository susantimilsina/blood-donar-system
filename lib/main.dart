import 'package:blood_doner/ui/shared/setup_snackbar_ui.dart';
import 'package:blood_doner/ui/shared/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:blood_doner/app/app.locator.dart';
import 'app/app.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  //     options: const FirebaseOptions(
  //         apiKey: "XXX",
  //         authDomain: "XXX",
  //         databaseURL: "XXX",
  //         projectId: "XXX",
  //         storageBucket: "XXX",
  //         messagingSenderId: "XXX",
  //         appId: "1:171753064353:android:7657ed524de1f70c4b6de0"));
  setupLocator();
  setupSnackbarUi();
  setupDialogUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.karla(),
          headlineLarge: GoogleFonts.bebasNeue(),
        ),
      ),
      navigatorObservers: [
        StackedService.routeObserver,
        // _LoggingObserver(),
      ],
      initialRoute: Routes.loginView,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
