import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twich_ui_clone/models/user.dart' as model;
import 'package:twich_ui_clone/providers/user_provider.dart';
import 'package:twich_ui_clone/screens/broadcast_screen.dart';
import 'package:twich_ui_clone/screens/home_screen.dart';
import 'package:twich_ui_clone/screens/login_screen.dart';
import 'package:twich_ui_clone/screens/onboarding_screen.dart';
import 'package:twich_ui_clone/screens/signup_screen.dart';
import 'package:twich_ui_clone/utils/authMethods.dart';
import 'package:twich_ui_clone/utils/colors.dart';
import 'package:twich_ui_clone/widgets/loading_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twich UI Clone',
      routes: {
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        BroadCast.routeName: (context) => BroadCast(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentUser(
          FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser!.uid
              : null,
        )
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              model.User.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }

          if (snapshot.hasData) {
            return HomeScreen();
          }
          return OnboardingScreen();
        },
      ),
    );
  }
}
