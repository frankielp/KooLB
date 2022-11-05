import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/data/user.dart';
import 'package:koolb/renter/renter.dart';

class RenterMainPage extends StatelessWidget {
  const RenterMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RenterPagesNavigation extends StatefulWidget {
  const RenterPagesNavigation({super.key});

  @override
  State<RenterPagesNavigation> createState() => _RenterPagesNavigationState();
}

class _RenterPagesNavigationState extends State<RenterPagesNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Profile',
          ),
        ],
      ),
      body: IconButton(
        icon: Icon(Icons.plus_one),
        onPressed: () async {
          await renter1.addInfoToFirebase();
          await host1.addInfoToFirebase();
          await place1.addToFirebase();
        },
      ),
    );
  }
}
