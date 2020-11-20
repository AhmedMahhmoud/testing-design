import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'designScreen.dart';

class VerficationCodeScreen extends StatefulWidget {
  @override
  _VerficationCodeScreenState createState() => _VerficationCodeScreenState();
}

String currentText;
TextEditingController controller = new TextEditingController();
StreamController<ErrorAnimationType> errorController =
    StreamController<ErrorAnimationType>();
var isvisible = false;

class _VerficationCodeScreenState extends State<VerficationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isvisible,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.arrow_forward),
        ),
      ),
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
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 4,
                        onSubmitted: (value) {
                          print("value is $value");
                        },
                        pinTheme: PinTheme(inactiveColor: Colors.black),
                        obscureText: false,
                        animationType: AnimationType.scale,
                        animationDuration: Duration(milliseconds: 300),
                        controller: controller,
                        cursorColor: Colors.black,
                        onCompleted: (v) {
                          print("Completed");
                          print("value is $v");
                          setState(() {
                            isvisible = true;
                          });
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
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
