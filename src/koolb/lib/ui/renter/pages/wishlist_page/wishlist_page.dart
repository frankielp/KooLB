import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/wishlist_page/detail_folder_wishlist_page.dart';

import '../../../../accommodation/accommodation.dart';
import '../../../../accommodation/category.dart' as Category;

class WishListFolder{
  String folderName = '';
  String leadImageUrl = '';
  List<String> images = [];
  List<Accommodation> accommodations = [];

  WishListFolder(
    String folderName,
    String leadImageUrl,
    List<String> images,
    List<Accommodation> accommodations)
    : folderName = folderName,
      leadImageUrl = leadImageUrl,
      images = images,
      accommodations = accommodations;
}


class FolderList extends StatefulWidget {
  const FolderList({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FolderList();
  }
}

class _FolderList extends State<FolderList>{

  @override
  Widget build(BuildContext context) {
    // Vy's data

    List<WishListFolder> wishListFolders = [
      WishListFolder(
          'Dreamer',
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          [
            "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
            "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",
          ],
          [
            Accommodation(
                [Category.Category.Hotel],
                0.5,
                4.5,
                1,
                1,
                1,
                [DateTime(2022, 12, 1, 0, 0), DateTime(2023, 1, 1, 0, 0)],
                [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
                'Việt Nam',
                'An Giang',
                'a1',
                GeoPoint(16.456661, 107.5960929)),
            Accommodation(
                [Category.Category.Hotel],
                0.5,
                4.5,
                1,
                1,
                1,
                [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
                [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
                'Việt Nam',
                'An Giang',
                'a2',
                GeoPoint(16.456661, 107.5960929)),
          ]

      ),
      WishListFolder(
          'Peaceful',
          "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          [
            "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
            "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          ],
          [
            Accommodation(
                [Category.Category.Hotel],
                0.5,
                4.5,
                1,
                1,
                1,
                [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
                [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
                'Việt Nam',
                'An Giang',
                'a2',
                GeoPoint(16.456661, 107.5960929)),
            Accommodation(
                [Category.Category.Hotel],
                0.5,
                4.5,
                1,
                1,
                1,
                [DateTime(2022, 12, 1, 0, 0), DateTime(2023, 1, 1, 0, 0)],
                [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
                'Việt Nam',
                'An Giang',
                'a1',
                GeoPoint(16.456661, 107.5960929)),
          ]
      )
    ];

    return Scaffold(
      body: ListView.builder(
          itemCount: wishListFolders.length,
          itemBuilder: (context, index){
            WishListFolder folder = wishListFolders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    folder.folderName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(folder.leadImageUrl,
                      height: 100.0,
                      width: 60.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailFolder(folder)));
                  },
                ),
              ),
            );
          }
      ),
    );
  }
}

AppBar customAppBar(BuildContext context, String title){
  return AppBar(
    toolbarHeight: 150,

    title: Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: Colors.white
          ),
        ),
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
          gradient: LinearGradient(
              colors: [Turquois, sky],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    ),
  );
}

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(context, "Your Wish List"),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0, bottom: 8.0),
              child: FolderList(),
            )
          )
        ],
      ),
    );
  }
}