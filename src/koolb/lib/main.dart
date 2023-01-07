// import 'dart:js';
// import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
// new
// new
import 'package:firebase_core/firebase_core.dart'; // new
// new
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/list_accommodations/view_list_accommodations.dart';
import 'package:koolb/ui/renter/pages/google_maps.dart';
import 'package:koolb/ui/renter/pages/homepage/search.dart';
import 'package:koolb/ui/renter/pages/profile_page.dart';
import 'package:koolb/ui/renter/pages/setting_page.dart';
import 'package:koolb/ui/sign_up_screen.dart';
// import 'package:koolb/ui/welcoming_page.dart';
// new
import 'firebase_options.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/firebase_options.dart';
import 'firebase_options.dart';
import 'package:koolb/ui/sign_in_screen.dart' as SignInPage;
import 'package:koolb/ui/renter/pages/notification_page.dart';
import 'package:koolb/ui/host/pages/insight_page.dart';
import 'ui/renter/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const KoolB());
}

class KoolB extends StatelessWidget {
  const KoolB({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KooLB',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextTheme(
            headline6: TextStyle(color: labelColor, fontSize: 18),
          ).headline6,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        bottomAppBarColor: Colors.green,
      ),
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SignUpScreen(),
    );
  }
}
