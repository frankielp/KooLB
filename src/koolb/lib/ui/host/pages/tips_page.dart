// CLASS OF A TIP
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../decoration/color.dart';

class TipsModel{
  String? tipName;
  String? tipContent;

  TipsModel({this.tipName, this.tipContent});

  TipsModel.fromSnapshot(snapshot){
    tipName = snapshot.data()['tipName'];
    tipContent = snapshot.data()['tipContent'];
  }
}


// DISPLAY TOP TITLE
Widget CustomTopBar(BuildContext context){
  return Container(
    padding: const EdgeInsets.only(top: 70.0, right: 130.0),
    height: 170,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28)
      ),
      gradient: LinearGradient(
          colors: [Turquois, BlueJean],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Hosting tips',
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 8.0, bottom: 15.0),
            child: Text(
              'Hosting is not difficult!',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          )
        ]
    ),
  );
}


// GET DATA
Future<List<TipsModel>?> readData() async{
  List<TipsModel> tips = [];
  var data = await FirebaseFirestore.instance
        .collection('tip')
        .get();
  tips = List.from(data.docs.map((doc) => TipsModel.fromSnapshot(doc)));

  return tips;
}


// DISPLAY LIST OF TIPS
Widget TipsList(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 15.0, right: 8.0, bottom: 14.0),
    child: FutureBuilder(
        future: readData(),
        builder: (context, data){
          if (data.hasError){
            return Center(child: Text("${data.error}"),);}
          else if (data.hasData){
            var tips = data.data as List<TipsModel>;
            return ListView.separated(
                itemBuilder: (context, index){
                  return ListTile(
                      title: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tips[index].tipName.toString(),
                                style: TextStyle(
                                    color: BlueJean,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ReadMoreText(
                                  tips[index].tipContent.toString().replaceAll("\\n", "\n"),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  trimLines: 3,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: " Show More",
                                  trimExpandedText: " Show Less ",
                                  lessStyle: TextStyle(
                                      color: Turquois
                                  ),
                                  moreStyle: TextStyle(
                                      color: Turquois
                                  ),
                                ),
                              ),
                            ],
                          )
                      ));
                },
                separatorBuilder: (BuildContext content, int index) =>
                const Divider(
                  color: Colors.grey,
                  height: 20,
                ),
                itemCount: tips.length);
          }
          else{
            return Container();
          }
        }),
  );
}


// TIPS PAGE
class TipsPage extends StatefulWidget{
  const TipsPage({Key? key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _TipsPage();
  }
}

class _TipsPage extends State<TipsPage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomTopBar(context),
          Expanded(
              child: TipsList(context)
          )],
      ),
    );
  }
}
