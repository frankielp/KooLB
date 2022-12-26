
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';

import '../../../../component/list_accommodation_item.dart';
import '../../../../wishlist/wishlist_folder.dart';
import 'folder_detail_page.dart';

class ListFolderDialog extends StatefulWidget{
  final AccommodationItem pressedAccommodation;

  ListFolderDialog(this.pressedAccommodation);

  @override
  State<StatefulWidget> createState() {
    return _ListFolderDialog();
  }
}

class _ListFolderDialog extends State<ListFolderDialog>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Divider(
          color: Colors.grey.shade200,
          thickness: 0.5,
        ),
        //ListFolderInDialog()
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0, bottom: 8.0),
              child: FolderList(),
            )
        )
      ],
    );
  }
}

class ListFolderInDialog extends FolderList{
  final AccommodationItem pressedAccommodation;

  ListFolderInDialog({required this.pressedAccommodation});

  onTapFolder(WishListFolder folder, BuildContext context){
    // Sửa lại cho dialog
  }

}