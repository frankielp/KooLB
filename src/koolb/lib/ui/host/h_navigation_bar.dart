import 'package:flutter/material.dart';
import 'package:koolb/ui/host/pages/calendar_page.dart';
import 'package:koolb/ui/host/pages/chat_page.dart';
import 'package:koolb/ui/host/pages/create_accommodation/create_accommodation.dart';
import 'package:koolb/ui/host/pages/insight_page.dart';
import 'package:koolb/ui/host/pages/menu_page.dart';
import 'package:koolb/ui/host/pages/reservation_page.dart';

class HostPagesNavigator extends StatefulWidget {
  const HostPagesNavigator({super.key});

  @override
  State<HostPagesNavigator> createState() => _HostPagesNavigatorState();
}

class _HostPagesNavigatorState extends State<HostPagesNavigator> {
  List pages = [
    const ReservationPage(),
    const ChatPage(),
    CreateAccommodation(hostName: "Name"),
  ];

  int currentPage = 0;

  void onTap(int index){
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
        backgroundColor:Colors.white,
        onTap: onTap,    
        currentIndex: currentPage,    
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.maps_home_work),
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home),
            label: 'Create Accommodation',
          ),
        ],
      ),
    );
  }
}