import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/ui/renter/pages/wishlist/folder_wishlist.dart';
import '../../../../decoration/color.dart';
import '../../../../wishlist/wishlist.dart';
import 'detail_folder_page.dart';

const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class FolderList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FolderList();
  }

  onTapFolder(WishlistFolder folder, BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailFolder(folder)));
  }
}


class _FolderList extends State<FolderList>{
  List<WishlistFolder> _folders = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUserFoldersList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _folders.length,
          itemBuilder: (context, index){
            WishlistFolder folder = _folders[index];
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
                    child: Image.network(folder.leadingUrl.toString(),
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

  Future getUserFoldersList() async{
    var data = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(renterID)
        .collection('folders')
        .orderBy('folderName')
        .get();

    setState(() {
      _folders = List.from(data.docs.map((doc) => WishlistFolder.fromSnapshot(doc)));
    });
    print(_folders);
  }
}

class WishlistPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WishlistPage();
  }
}

class _WishlistPage extends State<WishlistPage>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: customAppBar(context, 'Your Wish List'),
        body: Column(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0, bottom: 8.0),
                      child: FolderList()
                  )
              )
            ]
        )
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
