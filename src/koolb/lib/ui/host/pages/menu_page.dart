import 'package:flutter/material.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/ui/host/pages/create_accommodation/create_accommodation.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Create new Accommodation'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAccommodation(hostName: name),
            ),
          );
        },
      ),
    );
  }
}
