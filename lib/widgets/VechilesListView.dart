import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:hovo_design/screens/HomeDesign.dart';

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
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.all(15),
        child: MaterialButton(
          color: Colors.white,
          child: Text("Select your vechile \n to continue ",
              style: TextStyle(fontWeight: FontWeight.w700)),
          onPressed: () {
            Get.bottomSheet(
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    padding: EdgeInsets.all(10),
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select an option :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
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
                          viewportFraction: 0.8,
                          scrollDirection: Axis.horizontal,
                          scale: 0.9,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => setState(() {
                                currentIndex = index;
                              }),
                              child: Container(
                                margin: EdgeInsets.only(right: 25),
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
                        )),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage("lib/assets/images/dollar.png"),
                              width: 80,
                              height: 70,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Cash",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green[600]),
                              padding: EdgeInsets.all(15),
                              child: Center(
                                  child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
