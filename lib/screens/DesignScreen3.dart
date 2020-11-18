import 'package:flutter/material.dart';

import 'designScreen.dart';

class DesignScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Stack(
                children: [
                  Container(
                      height: 500,
                      decoration: BoxDecoration(color: Color(0xFF009FFD))),
                  Positioned(
                      child: Center(
                    child: Opacity(
                      opacity: 0.1,
                      child: Image(
                        height: 500,
                        fit: BoxFit.fitHeight,
                        image: AssetImage("lib/assets/images/Routes.jpg"),
                      ),
                    ),
                  )),
                  Positioned(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Image(
                        image: AssetImage("lib/assets/images/hovo logo.png"),
                        height: 200,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone Verfication"),
                  Text(
                    "Enter your OTP code below",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 5, top: 5),
                      width: 300,
                      padding: EdgeInsets.all(6),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "5412 5152 5125 5125",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontSize: 16),
                            suffixIcon: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFF009FFD)),
                                child: Icon(Icons.arrow_forward,
                                    size: 20, color: Colors.white))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Resend code in"),
                      Text(
                        "10 seconds",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),

            // Divider(),Container(height: 50,)
          ],
        ),
      ),
    );
  }
}
