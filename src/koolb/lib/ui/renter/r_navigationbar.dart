import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koolb/ui/renter/pages/chat_page.dart';
import 'package:koolb/ui/renter/pages/google_maps.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/renter/pages/setting_page.dart';
import 'package:koolb/ui/renter/pages/wishlist_page.dart';
import 'package:koolb/data/user.dart';
import 'package:koolb/renter/renter.dart';

class RenterPagesNavigation extends StatefulWidget {
  const RenterPagesNavigation({super.key});

  @override
  State<RenterPagesNavigation> createState() => _RenterPagesNavigationState();
}

class _RenterPagesNavigationState extends State<RenterPagesNavigation> {
  List pages = [
    const RenterMaps(),
    const WishlistPage(),
    const ChatPage(),
    const SettingPage(),
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
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
      // body: IconButton(
      //   icon: Icon(Icons.plus_one),
      //   onPressed: () async {
      //     await renter1.addInfoToFirebase();
      //     await host1.addInfoToFirebase();
      //     await place1.addToFirebase();
      //   },
      // ),
    );
  }
}
