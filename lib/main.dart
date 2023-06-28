import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:untitled1/services/auth.dart';
import 'package:untitled1/models/user.dart';
import 'package:untitled1/screens/wrapper.dart';
import 'screens/authentication/forgotpassword.dart';

Color topcolor = Colors.red, bottomColor = Colors.red;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          // apiKey: 'AIzaSyD0l-4knvNtKLuvljcljtQYzkzydkyFNYg',
          //   appId: '1:384318126501:android:2cdc35290ef4611677104c',///datrack
          //   messagingSenderId: '384318126501',projectId: 'datrack-8ee9f')
          apiKey: 'AIzaSyDytZzMm5qumYwjXdICEjJwTSM5I3xyM94',
          appId: '1:503477268361:android:992eaf60535859fce47b58',

          /// miniproject
          messagingSenderId: '503477268361',
          projectId: 'miniproject-beea5'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NewUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          'forgot_password': (context) => ForgotPassWord(),
        },
      ),
    );
  }
}

/////////////////

////////////

/////////////
