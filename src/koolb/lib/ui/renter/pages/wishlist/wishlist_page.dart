import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/wishlist/folder_detail_page.dart';
import 'package:koolb/wishlist/wishlist_folder.dart';
import '../../../../accommodation/accommodation.dart';
import '../../../../accommodation/category.dart' as Category;

// class WishListFolder{
//   String folderName = '';
//   String leadImageUrl = '';
//   List<String> images = [];
//   List<Accommodation> accommodations = [];
//
//   WishListFolder(
//       String folderName,
//       String leadImageUrl,
//       List<String> images,
//       List<Accommodation> accommodations)
//       : folderName = folderName,
//         leadImageUrl = leadImageUrl,
//         images = images,
//         accommodations = accommodations;
// }


class FolderList extends StatefulWidget {
  List<WishListFolder> wishListFolders = [];

  FolderList({Key? key}): super(key: key);

  onTapFolder(WishListFolder folder, BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailFolder(folder)));
  }

  @override
  State<StatefulWidget> createState() {
    return _FolderList();
  }
}

class _FolderList extends State<FolderList>{

  List<WishListFolder> wishListFolders = [
    WishListFolder(
      'Dreamer',
      "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
    ),
    WishListFolder(
      'Peaceful',
      "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
    )
  ];

  @override
  Widget build(BuildContext context) {
    // Vy's data

    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
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
                    this.widget.onTapFolder(folder, context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => DetailFolder(folder)));
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