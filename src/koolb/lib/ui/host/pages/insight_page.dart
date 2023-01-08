import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData({this.x, this.y});
  final DateTime? x;
  final int? y;
}

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => HostInsightPage();
}

class HostInsightPage extends State<InsightPage> {
  List<_ChartData> chartData = <_ChartData>[];

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue =
        await FirebaseFirestore.instance.collection("rating").get();
    List<_ChartData> list = snapShotsValue.docs
        .map((e) => _ChartData(
            x: DateTime.fromMillisecondsSinceEpoch(
                e.data()['x'].millisecondsSinceEpoch),
            y: e.data()['y']))
        .toList();
    setState(() {
      chartData = list;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 66, 61, 206),
                Color.fromARGB(255, 186, 208, 255),
                Color.fromARGB(255, 84, 92, 166),
              ])),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HOST INSIGHT',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.analytics_rounded,
                          color: Colors.black,
                          size: 30,
                        )
                      ],
                    ),
                    ListTile(
                      title: Text(
                        '========= Rating insight =========',
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        'We have analized your data for the past frametime. If you have any trouble with the statistic due to new rating coming, please refresh this page.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Container(
                      height: 400,
                      child: SfCartesianChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          primaryXAxis: DateTimeAxis(),
                          series: <LineSeries<_ChartData, DateTime>>[
                            LineSeries<_ChartData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y)
                          ]),
                    ),
                    ListTile(
                      title: Text(
                        '========= Idea for host =========',
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        'In order to boost your own products, we recommend using this rating analysis to track customers ideal. The more interesting your post accomodation is, the higher the rating star is.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ]))),
        ),
      ),
    );
  }
}
