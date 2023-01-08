import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as _category;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:koolb/chat/chat.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/decoration/widget.dart';
import 'package:koolb/ui/chat/conservation_list.dart';
import 'package:koolb/ui/renter/pages/booking/basic_book.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String description;
  final String address;
  final String imagePath;
  final double rating;
  final double price;
  final int room;
  final String accommodationID;
  final int guests;
  final int children;
  final List<_category.Category> category;
  final String userId;
  final String hostName;
  bool isFavorite;
  DetailsPage({
    Key? key,
    required this.description,
    required this.address,
    required this.imagePath,
    required this.accommodationID,
    required this.isFavorite,
    required this.name,
    required this.rating,
    required this.price,
    required this.room,
    required this.guests,
    required this.children,
    required this.category,
    required this.hostName,
    required this.userId,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Details Information",
          style: TextStyle(
            color: BlueJean,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(
          color: BlueJean,
          size: size.height * 0.035,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imageContainer(),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: BlueJean,
                          ),
                          Text(
                            ((widget.rating * 10).toInt() / 10.0).toString(),
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.address,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                          ),
                          const Spacer(),
                          Text(
                            "\$ ${(widget.price * 10).toInt() / 10.0}",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            specWidget(
                              context,
                              Icons.home,
                              "${widget.room} Rooms",
                            ),
                            specWidget(
                              context,
                              Icons.child_care,
                              "${widget.children} Children",
                            ),
                            specWidget(
                              context,
                              Icons.people,
                              "${widget.guests} Adult",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      listCategories(widget.category, size),
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      Text(
                        "Descriptions",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              letterSpacing: 1.1,
                              height: 1.4,
                            ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      String chatId = await Chat.newChat(id, widget.userId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConversationList(
                                chatId: chatId,
                                currentUserId: id,
                                otherUserId: widget.userId,
                                otherUserName: widget.hostName),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: const Icon(
                        Icons.message,
                        color: BlueJean,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.isFavorite == true) {
                          widget.isFavorite = false;
                        } else {
                          widget.isFavorite = true;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: BlueJean,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BasicBook(
                              startDate: DateTime.now(),
                              endDate: DateTime.now().add(
                                const Duration(days: 2),
                              ),
                              adults: 1,
                              children: 1,
                              maxAdults: widget.guests,
                              maxChildren: widget.children,
                              price: widget.price,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: BlueJean,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(4, 4),
                              blurRadius: 20,
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        height: 55,
                        width: 55,
                        child: Center(
                          child: Text(
                            "BOOK NOW",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget specWidget(BuildContext context, IconData iconData, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: LightBlue2,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  listCategories(List<_category.Category> categories, size) {
    List<Widget> lists = List.generate(
        categories.length,
        (index) => CategoryItemInDetail(
              data: categories[index],
              size: size,
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 0),
      child: Row(children: lists),
    );
  }

  CategoryItemInDetail({required _category.Category data, required Size size}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.fromLTRB(3, 10, 5, 5),
      margin: const EdgeInsets.only(right: 10),
      width: size.width * 0.20,
      height: size.width * 0.12,
      decoration: BoxDecoration(
        color: LightBlue2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        child: Center(
          child: Text(
            data.toShortString(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  _imageContainer() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _downloadUrl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                snapshot.data!,
                width: size.width * 0.7,
                height: size.width * 0.7,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return SizedBox(
            width: size.width * 0.8,
            height: size.width * 0.8,
            child: const CircularProgressIndicator(
              color: BlueJean,
            ),
          );
        }
      },
    );
  }

  Future<String> _downloadUrl() async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('accommodationImages/${widget.accommodationID}.png')
        .getDownloadURL();

    return downloadUrl;
  }
}
