
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/component/fire_auth.dart';
import 'package:koolb/wishlist/wishlist_folder.dart';

class WishList{
  static int count = 0;
  String renterID;
  List<WishListFolder> folders;

  WishList(this.renterID, this.folders){
    this.renterID = renterID;
    this.folders = folders;
    count += 1;
  }

  // Future<void> addWishListToFirebase(){
  //   return FirebaseFirestore.instance
  //       .collection('wishlist')
  //       .doc(FireAuth().currentUser?.uid)
  //       .collection('folders')
  //       .doc();
  // }
}