import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/sign_in_screen.dart';
import 'package:koolb/ui/sign_up_screen.dart';
import 'package:koolb/user/renter.dart';
import 'package:koolb/util/load_data.dart';
import 'firebase_options.dart';

Renter renter = Renter("", "", "", "", [], []);
void main() async {
  loadData();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  loadData();
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
      body: SignInScreen(),
    );
  }
}
