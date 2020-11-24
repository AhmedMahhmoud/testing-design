import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovo_design/screens/VerificationCodeScreen.dart';

import 'package:hovo_design/widgets/LogoStackWid.dart';

class DesignPage extends StatefulWidget {
  @override
  _DesignPageState createState() => _DesignPageState();
}

TextEditingController phoneController = TextEditingController();

class _DesignPageState extends State<DesignPage> {
  String _verificationId;

  Future<void> _requestSMSCodeUsingPhoneNumber() async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "ahmed@gmail.com", password: "123456")
          .then((value) async {
        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: "ahmed");
      
      });

      // print(phoneController.text);
      //   await FirebaseAuth.instance.verifyPhoneNumber(
      //       phoneNumber: "+20" + phoneController.text,
      //       timeout: Duration(seconds: 60),
      //       verificationCompleted: (AuthCredential phoneAuthCredential) {
      //         print('Sign up with phone complete');
      //       },
      //       verificationFailed: (FirebaseAuthException error) =>
      //           print('error message is ${error.message}'),
      //       codeSent: (String verificationId, [int forceResendingToken]) {
      //         print('verificationId is $verificationId');
      //         setState(() {
      //           _verificationId = verificationId;
      //           print(_verificationId);
      //         });
      //       },
      //       codeAutoRetrievalTimeout: (value) {
      //         print(value);
      //
      //});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: phoneController.text.length == 11
            ? FloatingActionButton(
                onPressed: () async {
                  await _requestSMSCodeUsingPhoneNumber();
                  Get.to(VerficationCodeScreen(_verificationId));
                },
                child: Center(
                  child: Icon(Icons.arrow_forward),
                ),
              )
            : Container(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: LogoStack(),
              ),
              Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello Nice to meet you!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                    Text(
                      "Move it with Hovo",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Card(
                          elevation: 8,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    width: 40,
                                    image: AssetImage(
                                      "lib/assets/images/EgyptFlag.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("+20      "),
                                ],
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  validator: (String value) =>
                                      value.trim().isEmpty
                                          ? 'Phone is required'
                                          : null,
                                  style: TextStyle(letterSpacing: 2),
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: Icon(Icons.check),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Enter your phone number"),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "By creating an account,you agree to our",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Term of Service",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(" and "),
                            Text(
                              "Privacy policy",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(1, size.height - 120);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 140);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
