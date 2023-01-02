import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as _category;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/decoration/widget.dart';
import 'package:koolb/ui/renter/pages/booking/basic_book.dart';

class DetailsPage extends StatefulWidget {
  // thêm id
  final String description;
  final String address;
  final List<String> images;
  final String accommodationID;
  final Accommodation accommodation;
  bool isFavorite;
  DetailsPage({
    Key? key,
    required this.description,
    required this.address,
    required this.images,
    required this.accommodationID,
    required this.isFavorite,
    required this.accommodation,
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
                CarouselwithIndicatorDemo(
                  images: widget.images,
                ),
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
                            widget.accommodation.name,
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
                            // widget.accommodation.rating.toString(),
                            "5",
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
                            "\$ ${widget.accommodation.price}",
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
                              "${widget.accommodation.room} Rooms",
                            ),
                            specWidget(
                              context,
                              Icons.child_care,
                              "${widget.accommodation.children} Children",
                            ),
                            specWidget(
                              context,
                              Icons.people,
                              "${widget.accommodation.guests} Adult",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      listCategories(widget.accommodation.category, size),
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
                    onTap: () {},
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
                                Duration(days: 2),
                              ),
                              adults: 1,
                              children: 1,
                              maxAdults: widget.accommodation.guests,
                              maxChildren: widget.accommodation.children,
                              price: widget.accommodation.price,
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
      padding: EdgeInsets.only(bottom: 5, left: 0),
      child: Row(children: lists),
    );
  }

  CategoryItemInDetail({required _category.Category data, required Size size}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      padding: EdgeInsets.fromLTRB(3, 10, 5, 5),
      margin: EdgeInsets.only(right: 10),
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
            offset: Offset(0, 1), // changes position of shadow
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
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselwithIndicatorDemo extends StatefulWidget {
  final List<String> images;
  const CarouselwithIndicatorDemo({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  _CarouselwithIndicatorDemoState createState() =>
      _CarouselwithIndicatorDemoState();
}

class _CarouselwithIndicatorDemoState extends State<CarouselwithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.images.map((item) {
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: size.height * 0.45,
                // width: size.width,
                // margin: EdgeInsets.symmetric(vertical: 0),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(16),
                //   boxShadow: const [
                //     BoxShadow(
                //       color: Colors.black12,
                //       blurRadius: 3,
                //       spreadRadius: 3,
                //     ),
                //   ],
                // ),
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: size.width,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: size.height * 0.45,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 2.0,
            autoPlayCurve: Curves.easeInBack,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 900),
            viewportFraction: 0.8,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                width: 10,
                height: _current == entry.key ? 6 : 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black12)
                      .withOpacity(
                    _current == entry.key ? 0.5 : 0.2,
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
