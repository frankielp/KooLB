import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';
import '../../../../wishlist/wishlist.dart';
import '../../../list_accommodations/list_accommodation_tile.dart';
import '../../../list_accommodations/view_list_accommodations.dart';


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
      Future accommodation = Accommodation.getAccommodationByIdFuture(this.widget.folder.accommodationIDs[i]);
      lst.add(await accommodation);
    }
    setState(() {
      //accommodationItems = List.from(this.widget.folder.accommodationIDs.map((id) => Accommodation.getAccommodationById(id)));
      accommodations = lst;
    });
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    final _accommodationCollection =
    FirebaseFirestore.instance
        .collection('accommodation')
        .where('id', whereIn: this.widget.folder.accommodationIDs);

    Stream<QuerySnapshot> _queryListAccommodation =
    _accommodationCollection.snapshots();

    WishlistFolder folder = this.widget.folder;
    return Scaffold(
      appBar: customAppBar(context, folder.folderName.toString()),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: getUserAccommodationsList(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"),);
              }
              else if (data.hasData)
                if (data.data != null) {
                  List<Accommodation> lst = data.data as List<Accommodation>;
                  if (lst != null && lst.length > 0)
                    accommodations = data.data as List<Accommodation>;

                  return Expanded(
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
                                    child: ViewListAccommodations(
                                      listAccommodations: _queryListAccommodation,
                                    )
                                      //image: images,
                                    )
                                );
                          }
                      )
                  );
                }
              return Center(child: CircularProgressIndicator(color: Colors.grey));
            })
        ],
      ),
    );
  }

}