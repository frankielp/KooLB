import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/ui/admin/ad_navigation_bar.dart';
import 'package:koolb/ui/host/h_navigation_bar.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        bottomAppBarColor: Colors.green,
      ),
      home: const MyHomePage(title: "Home Page"),
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
      body: RenterPagesNavigation(),
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
