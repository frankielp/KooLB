import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/host/list_accommodations/accommodation_tile_host.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  static final _hostCollection = FirebaseFirestore.instance.collection('host');
  static final _accommodationCollection =
      FirebaseFirestore.instance.collection('accommodation');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
            stream: _getAccommodationsList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['accommodationIds'] != null &&
                    snapshot.data['accommodationIds'].length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data['accommodationIds'].length,
                    itemBuilder: (context, index) {
                      return AccommodationTileHost(
                        accommodationId: snapshot.data['accommodationIds']
                            [index],
                      );
                    },
                  );
                } else {
                  return _noAccommodationWidget();
                }
              } else {
                return _loadingWidget();
              }
            }),
      ),
    );
  }

  _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: BlueJean,
      ),
    );
  }

  _noAccommodationWidget() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Wow, such empty!',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          Image.asset('assets/images/empty.png'),
        ],
      ),
    );
  }

  _getAccommodationsList() {
    return _hostCollection.doc(id!).snapshots();
  }
}
