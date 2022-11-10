import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:koolb/ui/admin/pages/explore_page.dart';
import 'package:koolb/ui/admin/pages/request_page.dart';
import 'package:koolb/ui/admin/pages/setting_page.dart';
import 'package:koolb/ui/admin/pages/statistic_page.dart';

class AdminPagesNavigator extends StatefulWidget {
  const AdminPagesNavigator({super.key});

  @override
  State<AdminPagesNavigator> createState() => _AdminPagesNavigatorState();
}

class _AdminPagesNavigatorState extends State<AdminPagesNavigator> {
  List pages = [
    const ExplorePage(),
    const RequestPage(),
    const SettingPage(),
    const StatisticPage(),
  ];

  int currentPage = 0;

  void onTap(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentPage,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Statistic',
          ),
        ],
      ),
    );
  }
}

// class AdminPages extends StatefulWidget {
//   const AdminPages({super.key});

//   @override
//   State<AdminPages> createState() => _AdminPagesState();
// }

// class _AdminPagesState extends State<AdminPages> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//     )
//   }
//}