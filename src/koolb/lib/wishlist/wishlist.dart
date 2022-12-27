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

  Future getFolderById() async{
    var snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(renterID)
        .collection('folders')
        .doc(id)
        .get();

    if (!snapshot.exists){
      throw Exception('Folder does not exist');
    }

    Map<String, dynamic>? data = snapshot.data();
    String folderName = data?['folderName'];
    String leadingUrl = data?['leadingUrl'];
    List<String> accommodationIDs = [];
    data?['accommodationIDs'].forEach((value){
      accommodationIDs.add(value);
    });

    WishlistFolder wl = WishlistFolder(
        folderName: folderName,
        leadingUrl: leadingUrl);

    wl.accommodationIDs = accommodationIDs;
    return wl;
  }

  fromSnapshot(doc){
    folderName = doc.data()['folderName'];
    leadingUrl = doc.data()['leadingUrl'];
    List<String> accommodationIDs = [];
    doc.data()['accommodationIDs'].forEach((value){
      accommodationIDs.add(value);
    });
    this.accommodationIDs = accommodationIDs;
  }
}