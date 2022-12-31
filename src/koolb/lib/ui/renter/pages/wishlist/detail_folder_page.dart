import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';
import '../../../../wishlist/wishlist.dart';


class DetailFolder extends StatefulWidget{
  final WishlistFolder folder;

  DetailFolder(this.folder);

  @override
  State<StatefulWidget> createState() {
    return _DetailFolder();
  }
}

class _DetailFolder extends State<DetailFolder> {
  List<Accommodation> accommodations = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUserAccommodationsList();
  }


  Future getUserAccommodationsList() async{
    List<Accommodation> lst = [];
    for (int i = 0; i < this.widget.folder.accommodationIDs.length; ++i){
      // Future accommodation = FirebaseFirestore.instance
      //     .collection('accommodation')
      //     .doc(this.widget.folder.accommodationIDs[i])
      //     .get();
      //
      Future accommodation = Accommodation.getAccommodationById(this.widget.folder.accommodationIDs[i]);
      lst.add(await accommodation);
    }
    setState(() {
      //accommodationItems = List.from(this.widget.folder.accommodationIDs.map((id) => Accommodation.getAccommodationById(id)));
      accommodations = lst;
    });
    print("Yessssssssss");
    print(this.widget.folder.accommodationIDs);
    //print(accommodationItems[0].images);
  }

  @override
  Widget build(BuildContext context) {
    WishlistFolder folder = this.widget.folder;
    return Scaffold(
      appBar: customAppBar(context, folder.folderName.toString()),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: folder.accommodationIDs.length,
                  itemBuilder: (context, index) {
                    Accommodation accommodation = accommodations[index];
                    // List<String> images = folder.accommodationIDs[index].data
                    //     .images;
                    return Card(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.only(left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.05, right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.05),
                            child: AccommodationItem(
                              isFavorite: folder.accommodationIDs.contains(accommodation.id),
                              data: accommodation,
                              //image: images,
                            )
                        ));
                  }
              )
          )
        ],
      ),
    );
  }

}