import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class ConfirmScreen extends StatefulWidget {
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("lib/assets/images/hovo.jpeg"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Thanks for using Hovo ! ",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text(
                          "Your order is made successfully .\n Your order ID is : #1234",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        Text(
                          "If you have any details to enter please  \n specify them below ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Lottie.network(
                              "https://assets2.lottiefiles.com/packages/lf20_Vwcw5D.json",
                              repeat: false),
                          width: MediaQuery.of(context).size.width / 1.96,
                          height: MediaQuery.of(context).size.height / 5.06,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Text(
                      "Write your details here",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 4)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 0)),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    Divider(),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          {
                            Fluttertoast.showToast(
                                    msg:
                                        "Thank you,Your review has been recorded ",
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.green)
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(9),
                                  bottomLeft: Radius.circular(15)),
                              gradient: LinearGradient(
                                colors: [Color(0xff5C58C1), Color(0xff4FE8F3)],
                              )),
                          width: MediaQuery.of(context).size.width / 1.96,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
