import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/global_data.dart';
import '../../../../decoration/color.dart';
import '../../../../main.dart';
import '../../../../wishlist/wishlist.dart';
import 'detail_folder_page.dart';

const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class FolderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FolderList();
  }

  onTapFolder(WishlistFolder folder, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailFolder(folder)));
  }
}

class _FolderList extends State<FolderList> {
  List<WishlistFolder> _folders = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUserFoldersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getUserFoldersList(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(
                  child: Text("${data.error}"),
                );
              } else if (data.hasData) {
                setState(() {
                  _folders = data.data as List<WishlistFolder>;
                });
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _folders.length,
                  itemBuilder: (context, index) {
                    WishlistFolder folder = _folders[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              folder.folderName.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            leading: (folder.accommodationIDs != null &&
                                    folder.accommodationIDs.length > 0)
                                ? _imageContainer(folder.accommodationIDs[0])
                                : const Icon(Icons.houseboat_outlined),
                            // leading: ClipRRect(
                            //   borderRadius: BorderRadius.circular(5.0),
                            //   child: Image.network(folder.leadingUrl.toString(),
                            //     height: 100.0,
                            //     width: 60.0,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            onTap: () {
                              this.widget.onTapFolder(folder, context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => DetailFolder(folder)));
                            },
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  });
            }));
  }

  // LẤY LIST FOLDER VỚI THÔNG TIN
  Future getUserFoldersList() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(wishlistID)
        .get();

    setState(() {
      _folders = List.from(snapshot
          .data()?['folders']
          .map((doc) => WishlistFolder.fromSnapshot(doc)));
    });
    // print(_folders);
    // print("yesssss");
  }

  _imageContainer(accommodationID) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _downloadUrl(accommodationID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                snapshot.data!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return SizedBox(
            width: size.width * 0.8,
            height: size.width * 0.8,
            child: const CircularProgressIndicator(
              color: BlueJean,
            ),
          );
        }
      },
    );
  }

  Future<String> _downloadUrl(accommodationID) async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('accommodationImages/${accommodationID}.png')
        .getDownloadURL();

    return downloadUrl;
  }
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _WishlistPage();
  }
}

class _WishlistPage extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Your Wish List'),
      body: const Center(
        child: Text('Wishlist Page'),
      ),
    );
  }
}

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: 150,
    title: Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 45, color: Colors.white),
        ),
      ),
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28)),
          gradient: LinearGradient(
              colors: [Turquois, sky],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    ),
  );
}
