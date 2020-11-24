import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import 'WelcomeTitle.dart';

class Vechiles extends StatefulWidget {
  @override
  _VechilesState createState() => _VechilesState();
}

List<Map> myMap = [
  {"image": "lib/assets/images/1.5 ton.png", "name": "1.5 ton"},
  {"image": "lib/assets/images/1.5ton closed.png", "name": "1.5 ton closed"},
  {"image": "lib/assets/images/Bicycle.png", "name": "Bicycle"},
  {"image": "lib/assets/images/bolan.png", "name": "Bolan"},
  {"image": "lib/assets/images/jumbo closed.png", "name": "Jumbo Closed"},
  {"image": "lib/assets/images/Motorcycle.png", "name": "Motorcycle"},
  {"image": "lib/assets/images/ravi.png", "name": "Ravi"},
  {"image": "lib/assets/images/tricycle.png", "name": "Tricycle"},
  {"image": "lib/assets/images/winch.png", "name": "Winch"}
];

int currentIndex = 0;

class _VechilesState extends State<Vechiles> {
  Location _location = Location();

  Future getCurrentPos() async {
    currentLocation = await _location.getLocation();
  }

  var _future;

  LocationData currentLocation;
  @override
  void initState() {
    // TODO: implement initState
    _future = getCurrentPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: StatefulBuilder(
          builder: (context, setState) {
            return FutureBuilder<Object>(
                future: _future,
                builder: (context, snapshot) {
                  return Container(
                    width: 280,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    height: 200,
                    child: Container(
                      height: 255,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select an option :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: "Poppins-Bold"),
                          ),
                          Divider(),
                          Expanded(
                            child: Swiper(
                              fade: 0.5,
                              onIndexChanged: (value) {
                                currentIndex = value;
                                print(myMap[value]["name"]);
                              },
                              itemCount: myMap.length,
                              viewportFraction: 0.7,
                              scrollDirection: Axis.horizontal,
                              scale: 0.6,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => setState(() {
                                    currentIndex = index;
                                  }),
                                  child: Container(
                                    child: VechilesWidget(
                                        color: currentIndex == index
                                            ? Colors.blue[800]
                                            : Colors.grey[800],
                                        boxshadowColor: currentIndex == index
                                            ? Colors.blue[600]
                                            : Colors.grey[800],
                                        vechImage: myMap[index]["image"],
                                        vechName: myMap[index]["name"]),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                      "lib/assets/images/dollar.png"),
                                  width: 40,
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Cash",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection("shipments")
                                        .add({
                                      "userID":
                                          FirebaseAuth.instance.currentUser.uid,
                                      "shipDate": DateTime.now(),
                                      "userLat": currentLocation.latitude,
                                      "userLon": currentLocation.longitude,
                                      "veichName": myMap[currentIndex]["name"],
                                      "veichImg": myMap[currentIndex]["image"],
                                    });
                                  },
                                  child: Container(
                                      width: 80,
                                      height: 30,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.green[600]),
                                      padding: EdgeInsets.all(6),
                                      child: Center(
                                          child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
