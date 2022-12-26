import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/wishlist/list_folder_dialog.dart';
import 'package:koolb/ui/renter/pages/wishlist/wishlist_page.dart';
import 'package:koolb/wishlist/wishlist.dart';
import 'package:koolb/wishlist/wishlist_folder.dart';

class AccommodationItem extends StatefulWidget {
  const AccommodationItem({super.key, this.data, this.onTap, this.image});

  final data;
  final image;
  final GestureTapCallback? onTap;

  @override
  State<AccommodationItem> createState() => _AccommodationItemState();
}

class _AccommodationItemState extends State<AccommodationItem> {
  @override
  int currentPage = 0;

  Widget build(BuildContext context) {
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
            itemCount: widget.image.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  // widget.data["image"][index],
                  widget.image[index],
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
              widget.image.length,
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
            top: size.height * 0.035, left: size.width * 0.62),
          child: IconButton(
            onPressed: (){
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
                      initialChildSize: 0.4,
                      maxChildSize: 0.9,
                      minChildSize: 0.32,
                      builder: (context, scrollController){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(25.0),
                              topRight: const Radius.circular(25.0),
                            ),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            controller: scrollController,
                            children: [
                                ListTile(
                                  leading: IconButton(
                                      onPressed: (){
                                        // PHAI TRA VE AccommdationItem va pressed folder
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close)
                                  ),
                                  title: Text('Your wish list'),
                                ),
                                ListTile(
                                  onTap: (){
                                    createAskDialog(context).then((onValue){
                                      if (onValue != null) {
                                        print('yes');
                                        // GOI HAM CLOSE DRAGGABLE PHIA TREN?,
                                        // LAY VE: TEN FOLDER + AccommodationItem
                                        WishListFolder folder = WishListFolder(onValue, '');
                                        folder.addFolderToFirebase();
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                  title: Text('Create new collection'),
                                  leading: IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: 30,
                                    color: Colors.grey,
                                    onPressed: (){},
                                    ),
                                ),
                                Divider(
                                  color: Colors.red,
                                  thickness: 0.5,
                                    ),
                                SizedBox(
                                  height: 300,
                                  child: ListFolderInDialog(pressedAccommodation: this.widget,)
                                )
                              ],
                            ),
                        );
                        //   ListView(
                        //   controller: scrollController,
                        //   children: [
                        //     Row(
                        //       children: <Widget>[
                        //         Expanded(
                        //           child: IconButton(
                        //               onPressed: (){
                        //                 Navigator.pop(context);
                        //               },
                        //               icon: Icon(Icons.close)
                        //           ),
                        //         ),
                        //         Expanded(
                        //             child: Text('Your wish list'))
                        //       ],
                        //     ),
                        //     Divider(
                        //       color: Colors.red,
                        //       thickness: 0.5,
                        //     ),
                        //     ListFolderInDialog()
                        //   ],
                        // );
                  });
                  }
                  );
              },
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
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

  Future<dynamic> createAskDialog(BuildContext context){
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context){
          return AlertDialog(
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
}

addItemToFolderInFirebase(){}


class PressedHearIconResult{
  String name;

  PressedHearIconResult(this.name);
}
