import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MaterialButton(
          color: Colors.white,
          child: Text("Open bottom sheet"),
          onPressed: () {
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.all(10),
                height: 300,
                color: Colors.white,
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
                    Material(
                      elevation: 4,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Standard",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  "\$ 9.90",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                                Text(
                                  "3 min",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w100,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            Image(
                              width: 120,
                              height: 90,
                              image: AssetImage("lib/assets/images/bolan.png"),
                            )
                          ],
                        ),
                        width: 240,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlue[300],

                                offset: Offset(5.0, 8.0), //(x,y)
                                blurRadius: 12.0,
                              ),
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage("lib/assets/images/dollar.png"),
                          width: 100,
                          height: 70,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Cash",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        )
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.green),
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
