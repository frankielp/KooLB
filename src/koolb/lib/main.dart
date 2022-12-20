// import 'dart:js';
// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/chat_page.dart';
import 'package:koolb/ui/renter/pages/google_maps.dart';
import 'package:koolb/ui/renter/pages/homepage/search.dart';
import 'package:koolb/ui/renter/pages/setting_page.dart';
import 'package:koolb/ui/sign_up_screen.dart';
// import 'package:koolb/ui/welcoming_page.dart';
import 'package:koolb/ui/splash_screen.dart';
import 'package:provider/provider.dart'; // new
import 'firebase_options.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/ui/admin/ad_navigation_bar.dart';
import 'package:koolb/ui/host/h_navigation_bar.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';
import 'package:koolb/firebase_options.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:koolb/ui/admin/ad_navigation_bar.dart';
import 'package:koolb/ui/host/h_navigation_bar.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';
import 'ui/registration.dart';
import 'firebase_options.dart';
import 'package:koolb/ui/sign_in_screen.dart' as SignInPage;
import 'package:koolb/ui/renter/pages/notification_page.dart';
import 'package:koolb/ui/renter/pages/chatdetail.dart';

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
      // home: const MyHomePage(title: "Home Page"),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: chatPage(),
    );
  }
}



// class RenterPagesNavigation extends StatefulWidget {
//   const RenterPagesNavigation({super.key});

//   @override
//   State<RenterPagesNavigation> createState() => _RenterPagesNavigationState();
// }

// class _RenterPagesNavigationState extends State<RenterPagesNavigation> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Wishlist',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Message',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.man),
//             label: 'Profile',
//           ),
//         ],
//         backgroundColor: Colors.green,
//         fixedColor: Colors.blue,
//       ),
//     );
//   }
// }
