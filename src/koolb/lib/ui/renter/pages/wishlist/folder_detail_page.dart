import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';
import 'package:koolb/wishlist/wishlist_folder.dart';


class DetailFolder extends StatelessWidget{
  final WishListFolder folder;

  DetailFolder(this.folder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, folder.folderName),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: folder.accommodations.length,
                  itemBuilder: (context, index){
                    Accommodation accommodation = folder.accommodations[index].data;
                    List<String> images = folder.accommodations[index].image;
                    return Card(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                            child: AccommodationItem(
                              data: accommodation,
                              image: images,
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