import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/component/fire_auth.dart';

import '../../../../accommodation/category.dart' as Category;
import '../accommodation/accommodation.dart';
import '../component/list_accommodation_item.dart';

class WishListFolder{
  String folderName = '';
  String leadImageUrl = '';
  List<AccommodationItem> accommodations = [];
  List<String> accommodationIDs = ['2dqqQ03SpKWprkE3rKX3', '2dqqQ03SpKWprkE3rKX3'];
  int count = 0;

  WishListFolder(this.folderName, this.leadImageUrl){
    this.folderName = folderName;
    this.leadImageUrl = leadImageUrl;
  }

 Future<void> addFolderToFirebase(){
    List<String> images = [
      "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
      "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large"
    ];

   return FirebaseFirestore.instance
       .collection('wishlist')
       .doc(FireAuth().currentUser?.uid)
       .collection('folders')
       .add(<String, dynamic>{
         'folderName': folderName,
         'accommodationIDs': FieldValue.arrayUnion(accommodationIDs),
         'images': FieldValue.arrayUnion(images)
       })
       .then((value) => print('Booking Added'))
       .catchError((error) => print('Error $error'));;
 }
}
