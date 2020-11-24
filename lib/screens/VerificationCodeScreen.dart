import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'designScreen.dart';

class VerficationCodeScreen extends StatefulWidget {
  final String verifyid;

  VerficationCodeScreen(this.verifyid);
  @override
  _VerficationCodeScreenState createState() => _VerficationCodeScreenState();
}

String currentText;
TextEditingController controller = new TextEditingController();
StreamController<ErrorAnimationType> errorController =
    StreamController<ErrorAnimationType>();
var isvisible = false;
var smscode;

class _VerficationCodeScreenState extends State<VerficationCodeScreen> {
  void _signInWithPhoneNumberAndSMSCode() async {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: widget.verifyid, smsCode: smscode);
    final User user =
        (await FirebaseAuth.instance.signInWithCredential(authCreds)).user;
    print("User Phone number is" + user.phoneNumber);

    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isvisible,
        child: FloatingActionButton(
          onPressed: () {
            print(smscode);
            _signInWithPhoneNumberAndSMSCode();
          },
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
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 6,
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
                            smscode = v;
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
                  // Row(
                  //   children: [
                  //     Text("Resend code in"),
                  //     Text(
                  //       "10 seconds",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // )
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
