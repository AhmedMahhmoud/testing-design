import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovo_design/screens/ReviewScreen.dart';
import 'package:hovo_design/widgets/RideCardInfo.dart';

class RideHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: ReviewMyClipper(),
                    child: Stack(
                      children: [
                        Container(
                            height: 500,
                            decoration:
                                BoxDecoration(color: Color(0xFF009FFD))),
                        Positioned(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 100, right: 40),
                              child: Text(
                                "Ride History",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 23),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            child: Center(
                          child: Opacity(
                            opacity: 0.1,
                            child: Image(
                                height: 500,
                                fit: BoxFit.fitHeight,
                                image:
                                    AssetImage("lib/assets/images/Routes.jpg")),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Center(
                    child: Container(
                  height: Get.height * 0.8,
                  width: 340,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView(
                      children: [
                        RideHistoryFullCard(),
                        RideHistoryFullCard(),
                        RideHistoryFullCard(),
                        RideHistoryFullCard(),
                      ],
                    ),
                  ),
                )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class RideHistoryFullCard extends StatelessWidget {
  const RideHistoryFullCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 280,
        padding: EdgeInsets.only(left: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: RideCard(
                    mainCity: "Dokki",
                    insideCity: "Msdaa Street",
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                height: 40,
                child: DottedLine(
                  direction: Axis.vertical,
                  dashGapLength: 5,
                  dashRadius: 4,
                  lineThickness: 1,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: RideCard(
                    mainCity: "Shobra",
                    insideCity: "Rod El Farag",
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    "ID:1234",
                    style: TextStyle(color: Colors.grey, letterSpacing: 1),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10, bottom: 5),
                    child: Text(
                      "Today: 5:15 pm",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
