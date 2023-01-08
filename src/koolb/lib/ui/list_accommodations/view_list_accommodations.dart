import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/list_accommodations/list_accommodation_tile.dart';
import 'package:koolb/ui/renter/pages/booking/basic_book.dart';
import 'package:koolb/util/helper.dart';

import '../../data/global_data.dart';
import '../../wishlist/wishlist.dart';

class ViewListAccommodations extends StatefulWidget {
  Stream<QuerySnapshot> listAccommodations;
  ViewListAccommodations({super.key, required this.listAccommodations});

  @override
  State<ViewListAccommodations> createState() => _ViewListAccommodationsState();
}

class _ViewListAccommodationsState extends State<ViewListAccommodations> {
  // WISHLIST
  List<String> favoriteAccommodationIDs = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserFavoriteListIDs();
  }

  Future getUserFavoriteListIDs() async {
    List<String> tmp = [];
    var data = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(wishlistID)
        .get();

    List<WishlistFolder> folders = List.from(
        data.data()?['folders'].map((doc) => WishlistFolder.fromSnapshot(doc)));

    for (int i = 0; i < folders.length; ++i) {
      tmp = List.from(tmp)..addAll(folders[i].accommodationIDs);
    }
    setState(() {
      favoriteAccommodationIDs = tmp;
      //print(favoriteAccommodationIDs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.listAccommodations,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                debugPrint(data.toString());
                return ListAccommodationTile(
                  userId: data['userId'],
                  hostName: data['hostName'],
                  accommodationID: data['id'],
                  imagePath: data['imagePath'],
                  country: data['country'],
                  city: data['city'],
                  address: data['address'],
                  name: data['name'],
                  isFavorite:
                      favoriteAccommodationIDs.contains(accommodationID),
                  price: data['price'] * 1.0,
                  rating: data['rating'] * 1.0,
                  category: intArrayToListCategory(data['category']),
                  description: data['description'],
                  room: data['room'],
                  guests: data['adult'],
                  children: data['children'],
                );
              },
            );
          } else {
            return _emptyWidget();
          }
        } else {
          return _loadingDataWidget();
        }
      },
    );
  }

  _loadingDataWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: BlueJean,
      ),
    );
  }

  _emptyWidget() {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          const Text(
            'Wow, such empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Image.asset('assets/images/empty.png'),
        ]),
      ),
    );
  }
}
