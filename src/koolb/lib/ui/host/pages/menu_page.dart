import 'package:flutter/material.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/ui/host/pages/create_accommodation/create_accommodation.dart';
import 'package:koolb/ui/host/pages/tips_page.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  var _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _createNewAccommodation(),
        _viewTipsList(),
      ],
    ));
  }

  _createNewAccommodation() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        child: const Text('Create new Accommodation'),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CreateAccommodation(hostName: name),
          //   ),
          // );
          Navigator.push(
              _context,
              MaterialPageRoute(
                  builder: (context) => CreateAccommodation(hostName: name)));
        },
      ),
    );
  }

  _viewTipsList() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        child: const Text('View tips'),
        onPressed: () {
          Navigator.push(
            _context,
            MaterialPageRoute(
              builder: (context) => const TipsPage(),
            ),
          );
        },
      ),
    );
  }
}
