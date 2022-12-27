import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../decoration/color.dart';
import '../../../../wishlist/wishlist.dart';

class FolderList extends StatefulWidget {
  List<WishlistFolder> wishListFolders = [];

  FolderList({Key? key}): super(key: key);

  onTapFolder(WishlistFolder folder, BuildContext context){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => DetailFolder(folder)));
  }

  @override
  State<StatefulWidget> createState() {
    return _FolderList();
  }
}


class _FolderList extends State<FolderList>{

  List<WishlistFolder> wishListFolders = [
    WishlistFolder(
      folderName: 'Dreamer',
      leadingUrl: "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
    ),
    WishlistFolder(
      folderName: 'Peaceful',
      leadingUrl: "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
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
            WishlistFolder folder = wishListFolders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    folder.folderName.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    // child: Image.network(folder.leadImageUrl,
                    //   height: 100.0,
                    //   width: 60.0,
                    //   fit: BoxFit.fill,
                    // ),
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
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: customAppBar(context, "Your Wish List"),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 8.0, right: 8.0, bottom: 8.0),
                child: FolderList(),
              )
          )
        ],
      ),
    );
  }
}
