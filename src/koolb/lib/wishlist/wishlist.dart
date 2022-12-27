import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/component/fire_auth.dart';

const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class WishlistFolder{
  var id;
  String? folderName;
  String? leadingUrl;
  List<String> accommodationIDs = [];

  WishlistFolder({required this.folderName, required this.leadingUrl});


  WishlistFolder.fromSnapshot(snapshot){
    id = snapshot.id;
    print(id);
    folderName = snapshot.data()['folderName'];
    leadingUrl = snapshot.data()['leadingUrl'];
    accommodationIDs = List.from(snapshot.data()['accommodationIDs'].map((doc) => doc.toString()));
  }


  // THÊM FOLDER VỚI ITEM VÀO DATABASE
  Future<void> addFolderToDatabase(String accommodationID){
    //accommodationIDs.add(accommodationID);
    return FirebaseFirestore.instance
        .collection('wishlist')
        .doc(renterID)
        .collection('folders')
        .add(<String, dynamic>{
      'folderName': folderName,
      'leadingUrl': leadingUrl,
      'accommodationIDs': FieldValue.arrayUnion([accommodationID])
    })
        .then((value){
      //id = value.id;
      print('New folder added ${value.id}');
    })
        .catchError((error) => print('Error $error'));
  }


  // THÊM 1 ITEM VÀO FOLDER CÓ SẴN
  Future<void> addItemToFolderInDatabase(String accommodationID) async{
    return FirebaseFirestore.instance.collection('wishlist')
        .doc(renterID)
        .collection('folders')
        .doc(this.id)
        .update({'accommodationIDs': FieldValue.arrayUnion([accommodationID])})
        .then((value) => print("AccommodationIDs updated"))
        .catchError((onError) => print("Failed: $onError"));
    //await folder.update({'accommodationIDs': FieldValue.arrayUnion([accommodationID])});
  }

}