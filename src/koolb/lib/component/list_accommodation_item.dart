import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';

import '../wishlist/wishlist.dart';
import 'package:koolb/main.dart';

//const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class AccommodationItem extends StatefulWidget {
  AccommodationItem({super.key, this.data, this.onTap, required this.isFavorite});

  final data;
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
    return Stack(
      children: [
        Container(
          padding:
          EdgeInsets.only(right: size.width * 0.1, top: size.height * 0.03),
          height: size.height * 0.5,
          child: PageView.builder(
            onPageChanged: ((value) {
              setState(() {
                currentPage = value;
              });
            }),
            // itemCount: widget.data["image"].length,
            itemCount: widget.data.images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  // widget.data["image"][index],
                  widget.data.images[index],
                  height: size.height * 0.4,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ),
        Container(
          padding:
          EdgeInsets.only(right: size.width * 0.1, top: size.height * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              // widget.data["image"].length,
              widget.data.images.length,
                  (index) => buildDot(index: index),
            ),
          ),
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color:
          //       Colors.black.withOpacity(0.3),
          //       blurRadius: 5
          //     )
          //   ]
          // ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: size.height * 0.035,
              left: size.width * 0.62
          ),
          child: HeartIcon(this.widget.data, this.widget.isFavorite),
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
                  SizedBox(height: 3,),
                  Text(
                    widget.data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: DarkBlue,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Row (
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
    );
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

class HeartIcon extends StatefulWidget{
  var data;
  bool isFavorite;
  //List<String> favoriteInfo;
  HeartIcon(this.data, this.isFavorite);

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
          setState(() {
            //_favorite = !_favorite;
            this.widget.isFavorite = !this.widget.isFavorite;
          });
          if (this.widget.isFavorite == true) {
            onPressedHeartIcon(context, this.widget.data);
          }
          else{
            onPressedRemoveFavorite(context, this.widget.data);
          }
        },
        icon: (this.widget.isFavorite == false) ?
        Icon(Icons.favorite_outline_outlined, size: 30, color: Colors.white,) :
        Icon(Icons.favorite, size: 30, color: Colors.red)
    );
  }
}


// REMOVE 1 ITEM FAVORITE
Future onPressedRemoveFavorite(BuildContext context, data) async{
  var snapshot = await FirebaseFirestore.instance
                                    .collection('wishlist')
                                    .doc(renter.wishlistID)
                                    .get();

  List<WishlistFolder> folders = List.from(snapshot.data()?['folders'].map((doc) => WishlistFolder.fromSnapshot(doc)));

  WishlistFolder newFolder = WishlistFolder("", "");
  WishlistFolder oldFolder = WishlistFolder("", "");

  for (int i = 0; i < folders.length; ++i){
    if (folders[i].accommodationIDs.contains(data.id)) {
      oldFolder = WishlistFolder(folders[i].folderName, folders[i].leadingUrl);
      oldFolder.accommodationIDs = List<String>.from(folders[i].accommodationIDs);
      oldFolder.folderNumber = folders[i].folderNumber;

      folders[i].accommodationIDs.remove(data.id);
      newFolder = folders[i];

      print(oldFolder.accommodationIDs);
      print(newFolder.accommodationIDs);
      break;
    }
  }

  await FirebaseFirestore.instance.collection('wishlist')
      .doc(renter.wishlistID)
      .update({'folders': FieldValue.arrayRemove(convertListFolderToJson([oldFolder]))})
      .then((value) => print("Remove old folder"));

  if (newFolder.accommodationIDs.isEmpty == false) {
    await FirebaseFirestore.instance.collection('wishlist')
        .doc(renter.wishlistID)
        .update({'folders': FieldValue.arrayUnion(convertListFolderToJson([newFolder]))})
        .then((value) {
      showSnackBar(context, "Remove this item from your ${oldFolder.folderName} collection.");
      print("Updated new folder");
    });
  }
  else{
    showSnackBar(context, "Your collection ${oldFolder.folderName} has been deleted.");
    print("Your folder is deleted");
  }
}


// KHI ẤN VÀO TRÁI TIM
onPressedHeartIcon(BuildContext context, data){
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30)
          )
      ),
      builder: (BuildContext context){
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.75,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, srollController){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0)
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  controller: srollController,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (){
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
                        onPressed: (){
                          // CODE
                        },
                      ),
                      title: Text('Create new collection'),
                      onTap: (){
                        // CODE FUNCTION
                        onPressedCreateCollection(context, data);
                      },
                    ),
                    Divider(
                      color: Colors.red,
                      thickness: 0.7,
                    ),
                    SizedBox(
                      height: 700,
                      child: FolderListInSheet(data, renter.wishlistID),
                    )
                  ],
                ),
              );
            }
        );
      } //builder: builder
  );
}


// KHI ẤN TẠO COLLECTION MỚI
Future<dynamic> onPressedCreateCollection(BuildContext context, data) {
  return createAskDialog(context).then((onValue) {
    if (onValue != null) {
      WishlistFolder folder = WishlistFolder(onValue, data.images[0]);
      WishlistFolder.countFolder += 1;
      folder.addFolderToDatabase(context, data.id, renter);
  }
    // else if (onValue == null){
    //   Navigator.pop(context);
    // }
  }).then((value) => Navigator.pop(context));
}


// TẠO DIALOG ĐẶT TÊN COLLECTION
Future<dynamic> createAskDialog(BuildContext context){
  TextEditingController customController = TextEditingController();

  return showDialog(context: context, builder: (context){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))
      ),
      title: ListTile(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)
        ),
        title: Text('Your wish list'),
      ),
      content: TextField(
        controller: customController,
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            Navigator.of(context).pop(customController.text.toString());
          },
          elevation: 5.0,
          child: Text("Create"),
        )
      ],
    );
  }
  );
}


// HIỆN FOLDER LITS TRONG BOTTOM SHEET
class FolderListInSheet extends FolderList {
  var accommodationItem;
  var wishlistID;

  FolderListInSheet(this.accommodationItem, this.wishlistID);

  @override
  onTapFolder(WishlistFolder folder, BuildContext context) {
    folder.addItemToFolderInDatabase(context, folder, accommodationItem.id, wishlistID);
  }
}

