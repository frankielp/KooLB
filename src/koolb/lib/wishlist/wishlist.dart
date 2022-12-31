import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/main.dart';

import '../user/renter.dart';

class WishlistFolder{
  var id;
  static int countFolder = 0;
  int folderNumber = countFolder + 1;
  late String folderName;
  late String leadingUrl;
  List<String> accommodationIDs = [];

  WishlistFolder(this.folderName, this.leadingUrl);

  Map<String, dynamic> toJson(){
    return {
      'folderNumber': folderNumber,
      'folderName': folderName,
      'leadingUrl': leadingUrl,
      'accommodationIDs': accommodationIDs
    };
  }


  // THÊM FOLDER VỚI ITEM VÀO DATABASE
  Future<void> addFolderToDatabase(BuildContext context, String accommodationID, Renter renter) {
    accommodationIDs.add(accommodationID);
    if (renter.wishlistID != '') {
      return FirebaseFirestore.instance
          .collection('wishlist')
          .doc(renter.wishlistID)
          .update({'folders': FieldValue.arrayUnion([this.toJson()])})
          .then((value) {
            showSnackBar(context, "A new collection added!");
            print("Wishlist updated");
      });
    }
    return FirebaseFirestore.instance
        .collection('wishlist')
        .add(<String, dynamic>{
          'folders': FieldValue.arrayUnion(convertListFolderToJson([this]))
    })
        .then((value){
          renter.wishlistID = value.id;
          showSnackBar(context, "A new collection added!");
          print("New wishlist added");
    })
        .catchError((onError) => print("Failed: $onError"));
  }

  // Lấy 1 folder từ map
  WishlistFolder.fromSnapshot(snapshot){
    //id = snapshot.id;
    //print(id);
    folderNumber = snapshot['folderNumber'];
    folderName = snapshot['folderName'];
    leadingUrl = snapshot['leadingUrl'];
    accommodationIDs = List.from(snapshot['accommodationIDs'].map((doc) => doc.toString()));
  }


  // THÊM 1 ITEM VÀO FOLDER CÓ SẴN
  Future<void> addItemToFolderInDatabase(BuildContext context, WishlistFolder folder, String accommodationID, String wishlistID) async{
    accommodationIDs.add(accommodationID);

    var snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(wishlistID)
        .get();

    List<WishlistFolder> folders = List.from(snapshot.data()?['folders'].map((doc) => WishlistFolder.fromSnapshot(doc)));
    WishlistFolder newFolder = WishlistFolder("", "");
    WishlistFolder oldFolder = WishlistFolder("", "");

    for (int i = 0; i < folders.length; ++i){
      if (folders[i].folderNumber == folder.folderNumber) {
        oldFolder = WishlistFolder(folders[i].folderName, folders[i].leadingUrl);
        oldFolder.accommodationIDs = List<String>.from(folders[i].accommodationIDs);
        oldFolder.folderNumber = folders[i].folderNumber;

        folders[i].accommodationIDs.add(accommodationID);
        newFolder = folders[i];

        print(oldFolder.accommodationIDs);
        print(newFolder.accommodationIDs);
        break;
      }
    }

    await FirebaseFirestore.instance.collection('wishlist')
                              .doc(wishlistID)
                              .update({'folders': FieldValue.arrayRemove(convertListFolderToJson([oldFolder]))})
                              .then((value) => print("Remove old folder"));

    await FirebaseFirestore.instance.collection('wishlist')
        .doc(wishlistID)
        .update({'folders': FieldValue.arrayUnion(convertListFolderToJson([newFolder]))})
        .then((value){
          showSnackBar(context, "Added to your ${oldFolder.folderName} collection");
          print("Updated new folder");
    });
  }

}

List<Map> convertListFolderToJson(List<WishlistFolder> folders){
  List<Map> res = [];
  folders.forEach((element) {
    Map folder = element.toJson();
    res.add(folder);
  });
  return res;
}

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text,
         style: TextStyle(
          color: Colors.white,
          fontSize: 30
        ),),
        duration: Duration(seconds: 10),
      )
  );
}