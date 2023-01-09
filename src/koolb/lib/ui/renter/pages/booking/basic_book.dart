import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koolb/booking/booking.dart';

const renterID = 'HgvSKaOM6uSLK9qrH2ZL';
const accommodationID = '2dqqQ03SpKWprkE3rKX3';

class BasicBook extends StatefulWidget {
  DateTime startDate;
  DateTime endDate;
  int adults;
  int maxAdults;
  int children;
  int maxChildren;
  double price;
  BasicBook({
    super.key,
    required this.startDate,
    required this.endDate,
    this.adults = 1,
    this.children = 0,
    required this.maxAdults,
    required this.maxChildren,
    required this.price,
  });

  @override
  State<BasicBook> createState() => _BasicBookState();
}

class _BasicBookState extends State<BasicBook> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //main info
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Wrap(
                      spacing: 0,
                      runSpacing: 0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        //Accommodation Info
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 5, 10, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // image of house
                              Image.asset(
                                'assets/images/onboarding1.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Place name',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      'Address',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.star_purple500_outlined,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                        Text(
                                          'Rating',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    // Trip
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your trip',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            _defaultDivider(),
                            // check in date
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 2, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Start',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  // check in date
                                  ElevatedButton(
                                    onPressed: () async {
                                      final datePicked1Date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: widget.startDate,
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime(DateTime.now().year + 5),
                                      );
                                      if (datePicked1Date != null) {
                                        setState(
                                          () => widget.startDate = DateTime(
                                            datePicked1Date.year,
                                            datePicked1Date.month,
                                            datePicked1Date.day,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, color: Colors.black)),
                                    child: Text(
                                      _dateToString(widget.startDate),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // check out date
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'End',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final datePicked1Date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: widget.endDate,
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime(DateTime.now().year + 5),
                                      );
                                      if (datePicked1Date != null) {
                                        setState(
                                          () => widget.endDate = DateTime(
                                            datePicked1Date.year,
                                            datePicked1Date.month,
                                            datePicked1Date.day,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, color: Colors.black)),
                                    child: Text(
                                      _dateToString(widget.endDate),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Adults
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 16, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Adults'),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.adults =
                                                  max(--widget.adults, 1);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('${widget.adults}'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.adults = min(
                                                  ++widget.adults,
                                                  widget.maxAdults);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Children
                            //Adults
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 16, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Children'),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.children =
                                                  max(--widget.children, 0);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('${widget.children}'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.children = min(
                                                  ++widget.children,
                                                  widget.maxChildren);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total price',
                                style: Theme.of(context).textTheme.bodyLarge),
                            _defaultDivider(),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${widget.endDate.difference(widget.startDate).inDays} x \$${widget.price}'),
                                  Text(
                                      '\$${widget.endDate.difference(widget.startDate).inDays * widget.price * 100 / 100}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //cancel button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  OutlinedButton(
                    onPressed: () {
                      Booking booking = Booking(
                        renterID: renterID,
                        accommodationID: accommodationID,
                        checkinDate: widget.startDate,
                        checkoutDate: widget.endDate,
                        numAdults: widget.adults,
                        numChildren: widget.children,
                      );

                      booking.addInfoToFirebase();

                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok')),
                              ], title: Text('Book complete'))));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Book',
                      style: TextStyle(color: Colors.black),
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

  String _dateToString(DateTime date) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(date);
  }

  Widget _defaultDivider() {
    return Divider(
      color: Colors.grey.shade200,
      thickness: 0.5,
    );
  }
}
