import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:koolb/ui/admin/pages/posting.dart';
import 'package:koolb/ui/host/pages/insight_page.dart';
import 'package:koolb/ui/renter/pages/profile_page.dart';

class AdminPagesNavigator extends StatefulWidget {
  const AdminPagesNavigator({super.key});

  @override
  State<AdminPagesNavigator> createState() => _AdminPagesNavigatorState();
}

class _AdminPagesNavigatorState extends State<AdminPagesNavigator> {
  List pages = [
    const PostingAdmin(),
    const InsightPage(),
    const ProfilePage(),
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
            icon: Icon(Icons.analytics_outlined),
            label: 'Insight',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
