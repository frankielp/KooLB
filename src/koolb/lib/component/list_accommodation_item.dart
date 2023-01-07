import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/accommodation_detail.dart';

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
    return GestureDetector(
      onTap: () {
        setState(
          () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return DetailsPage(
            //         description: widget.data.city,
            //         address: '${widget.data.city} ${widget.data.country}',
            //         imagePath: widget.image,
            //         accommodationID: "widget.data.accommodationID",
            //         isFavorite: false,
            //         accommodation: widget.data,
            //       );
            //     },
            //   ),
            // );
          },
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                right: size.width * 0.1, top: size.height * 0.03),
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
            padding: EdgeInsets.only(
                right: size.width * 0.1, top: size.height * 0.04),
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
            width: size.width * 0.5,
            margin: EdgeInsets.only(
                top: size.height * 0.42, left: size.width * 0.35),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: LightBlue2,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5)
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.country + ', ' + widget.data.city,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 111, 110, 110),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.data.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: DarkBlue,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price: ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${'\$${widget.data.price}'} night',
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
}
