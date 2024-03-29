import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';

import '../data/global_data.dart';
import '../wishlist/wishlist.dart';
import 'package:koolb/main.dart';

//const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class AccommodationItem extends StatefulWidget {
  AccommodationItem(
      {super.key, this.data, this.onTap, required this.isFavorite});

  final data;
  final image = [];
  final GestureTapCallback? onTap;
  bool isFavorite;
  //List<String> favoriteInfo;

  @override
  State<AccommodationItem> createState() => _AccommodationItemState();
}

class _AccommodationItemState extends State<AccommodationItem> {
  @override
  int currentPage = 0;

  Widget build(BuildContext context) {
    //print("AccommodationItem build: ${this.widget.favoriteInfo} ${DateTime.now()}");
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          setState(
            () {},
          );
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  right: size.width * 0.1, top: size.height * 0.03),
              height: size.height * 0.5,
              child: PageView.builder(
                onPageChanged: ((value) {
                  setState(() {
                    currentPage = value;
                  });
                }),
                // itemCount: widget.data["image"].length,
                itemCount: widget.image.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      // widget.data["image"][index],
                      widget.image[index],
                      height: size.height * 0.4,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.035, left: size.width * 0.62),
              //child: HeartIcon(this.widget.data, this.widget.isFavorite),
            ),
            Container(
                width: size.width * 0.5,
                margin: EdgeInsets.only(
                    top: size.height * 0.42, left: size.width * 0.35),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: LightBlue2,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5)
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.country + ', ' + widget.data.city,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 111, 110, 110),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.data.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: DarkBlue,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Price: ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${'\$' + widget.data.price.toString()} night',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 5,
      width: currentPage == index ? 8 : 5,
      decoration: BoxDecoration(
        color: currentPage == index ? LightBlue : cardColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class HeartIcon extends StatefulWidget {
  var dataID;
  bool isFavorite;
  String imagePath;
  //List<String> favoriteInfo;
  HeartIcon(this.dataID, this.isFavorite, this.imagePath);

  @override
  State<StatefulWidget> createState() {
    return _HeartIcon();
  }
}

class _HeartIcon extends State<HeartIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (!this.widget.isFavorite) {
            onPressedHeartIcon(
                    context, this.widget.dataID, this.widget.imagePath)
                .then((value) {
              //if (value != null && value != '') {
              if (value != null && value != '')
                setState(() {
                  this.widget.isFavorite = !this.widget.isFavorite;
                });
              else if (value == null)
                setState(() {
                  this.widget.isFavorite = this.widget.isFavorite;
                });
            });
            setState(() {
              this.widget.isFavorite = !this.widget.isFavorite;
            });
          } else {
            onPressedRemoveFavorite(context, this.widget.dataID);
            setState(() {
              this.widget.isFavorite = !this.widget.isFavorite;
            });
          }
        },
        icon: !this.widget.isFavorite
            ? Icon(
                Icons.favorite_outline_outlined,
                color: Colors.white,
                size: 30,
              )
            : Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ));
  }
}

// REMOVE 1 ITEM FAVORITE
Future onPressedRemoveFavorite(BuildContext context, dataID) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('wishlist')
      .doc(wishlistID)
      .get();

  List<WishlistFolder> folders = List.from(snapshot
      .data()?['folders']
      .map((doc) => WishlistFolder.fromSnapshot(doc)));

  WishlistFolder newFolder = WishlistFolder("", "");
  WishlistFolder oldFolder = WishlistFolder("", "");

  for (int i = 0; i < folders.length; ++i) {
    if (folders[i].accommodationIDs.contains(dataID)) {
      oldFolder = WishlistFolder(folders[i].folderName, folders[i].leadingUrl);
      oldFolder.accommodationIDs =
          List<String>.from(folders[i].accommodationIDs);
      oldFolder.folderNumber = folders[i].folderNumber;

      folders[i].accommodationIDs.remove(dataID);
      newFolder = folders[i];

      print(oldFolder.accommodationIDs);
      print(newFolder.accommodationIDs);
      break;
    }
  }

  await FirebaseFirestore.instance
      .collection('wishlist')
      .doc(renter.wishlistID)
      .update({
    'folders': FieldValue.arrayRemove(convertListFolderToJson([oldFolder]))
  }).then((value) => print("Remove old folder"));

  if (newFolder.accommodationIDs.isEmpty == false) {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(renter.wishlistID)
        .update({
      'folders': FieldValue.arrayUnion(convertListFolderToJson([newFolder]))
    }).then((value) {
      showSnackBar(context,
          "Remove this item from your ${oldFolder.folderName} collection.");
      print("Updated new folder");
    });
  } else {
    showSnackBar(
        context, "Your collection ${oldFolder.folderName} has been deleted.");
    print("Your folder is deleted");
  }
}

// KHI ẤN VÀO TRÁI TIM
Future<dynamic> onPressedHeartIcon(
    BuildContext context, dataID, imagePath) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.75,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, srollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  controller: srollController,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // CODE CLOSE BOTTOM SHEET
                          Navigator.pop(context);
                        },
                      ),
                      title: Text('Your wish list'),
                    ),
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.add),
                        iconSize: 30,
                        color: Colors.grey,
                        onPressed: () {
                          // CODE
                        },
                      ),
                      title: Text('Create new collection'),
                      onTap: () {
                        // CODE FUNCTION
                        //onPressedCreateCollection(context, data);
                        onPressedCreateCollection(context, dataID, imagePath)
                            .then((value) => Navigator.of(context).pop(value));
                      },
                    ),
                    Divider(
                      color: Colors.red,
                      thickness: 0.7,
                    ),
                    SizedBox(
                      height: 700,
                      child: FolderListInSheet(dataID, wishlistID),
                    )
                  ],
                ),
              );
            });
      } //builder: builder
      );
}

// KHI ẤN TẠO COLLECTION MỚI
Future<dynamic> onPressedCreateCollection(
    BuildContext context, dataID, imagePath) {
  return createAskDialog(context).then((onValue) {
    if (onValue != null && onValue != '') {
      WishlistFolder folder = WishlistFolder(onValue, imagePath);
      WishlistFolder.countFolder += 1;
      folder.addFolderToDatabase(context, dataID);
    }
    // else if (onValue == null){
    //   Navigator.pop(context);
    // }
    return onValue;
  });
}

// TẠO DIALOG ĐẶT TÊN COLLECTION
Future<dynamic> createAskDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop("");
                },
                icon: Icon(Icons.close)),
            title: Text('Your wish list'),
          ),
          content: TextField(
            controller: customController,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(customController.text.toString());
              },
              elevation: 5.0,
              child: Text("Create"),
            )
          ],
        );
      });
}

// HIỆN FOLDER LITS TRONG BOTTOM SHEET
class FolderListInSheet extends FolderList {
  var dataID;
  var wishlistID;

  FolderListInSheet(this.dataID, this.wishlistID);

  @override
  onTapFolder(WishlistFolder folder, BuildContext context) {
    folder.addItemToFolderInDatabase(context, folder, dataID, wishlistID);

    // CLOSE BOTTOM SHEET
    Navigator.pop(context);
  }
}
