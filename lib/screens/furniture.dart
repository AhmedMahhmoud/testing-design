import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hovo_design/screens/ConfirmOrderScreen.dart';
import 'package:hovo_design/widgets/RowCalculations.dart';
import 'package:hovo_design/widgets/locatinPicker.dart';
import 'package:hovo_design/widgets/routeMenu.dart';
import 'package:get/get.dart';

class Furniture extends StatefulWidget {
  @override
  _FurnitureState createState() => _FurnitureState();
}

// Position senderPos, receiverPos;
String senderPos, receiverPos;
List<String> list = ["1 Room", "2 Rooms", "3 Rooms"];
String value = list.first;
int carpenter = 150;
int electrian = 150;
int cartonpackage = 50;
int comleteFlatPack = 500;
int initialValCarbenter = 0;
int initialValElecterian = 0;
int initialValCartonPackage = 0;
int initialValFlatPackage = 0;

class _FurnitureState extends State<Furniture> {
  void curbbenterFunction(
    int number,
  ) {
    if (number == 0) {
      {
        setState(() {
          if (initialValCarbenter >= carpenter) {
            initialValCarbenter -= carpenter;
          }
        });
      }
    } else {
      setState(() {
        initialValCarbenter += carpenter;
      });
    }
  }

  void electerican(
    int number,
  ) {
    if (number == 0) {
      {
        setState(() {
          if (initialValElecterian >= electrian) {
            initialValElecterian -= electrian;
          }
        });
      }
    } else {
      setState(() {
        initialValElecterian += electrian;
      });
    }
  }

  void cartoonPackageFun(
    int number,
  ) {
    if (number == 0) {
      {
        setState(() {
          if (initialValCartonPackage >= cartonpackage) {
            initialValCartonPackage -= cartonpackage;
          }
        });
      }
    } else {
      setState(() {
        initialValCartonPackage += cartonpackage;
      });
    }
  }

  void flatPackageFunc(
    int number,
  ) {
    if (number == 0) {
      {
        setState(() {
          if (initialValFlatPackage >= comleteFlatPack) {
            initialValFlatPackage -= comleteFlatPack;
          }
        });
      }
    } else {
      setState(() {
        initialValFlatPackage += comleteFlatPack;
      });
    }
  }

  var addressLoc = "Pick From Location";

  Future<String> getloc(Coordinates coordinates) async {
    var adr = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var address = adr.first;
    return address.locality +
        " " +
        address.adminArea +
        " " +
        address.subAdminArea;
  }

  @override
  void initState() {
    // TODO: implement initState
    if (senderPos != null) {
      print("sender not null");
    } else {
      print("sender null");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.blue[800],
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Estimated Cost :",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  (initialValCarbenter +
                              initialValCartonPackage +
                              initialValElecterian +
                              initialValFlatPackage)
                          .toString() +
                      " EGP",
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      if (initialValCarbenter +
                              initialValCartonPackage +
                              initialValElecterian +
                              initialValFlatPackage !=
                          0) {
                        Dialog errorDialog = Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0)), //this right here
                          child: Container(
                            width: 300,
                            height: 300,
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'Are you sure you want to confirm your order ?',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(ConfirmScreen());
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.green),
                                          ),
                                        ),
                                        FlatButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20),
                                            )),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Total cost is : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              ((initialValCarbenter +
                                                          initialValCartonPackage +
                                                          initialValElecterian +
                                                          initialValFlatPackage)
                                                      .toString() +
                                                  " EGP"),
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => errorDialog);
                      } else {
                        return Get.snackbar("Cant Confirm Your Order",
                            "Please Complete Your Order First",
                            colorText: Colors.black,
                            snackStyle: SnackStyle.FLOATING,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white);
                      }
                    },
                    child: Container(
                      child: Text(
                        "Confirm ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text("Filling Form"),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationPicker(pageCategory: "furniture",)));
                    if (result != null) {
                      print(result);
                      setState(() {
                        senderPos = result[1];
                      });
                    }
                  },
                  child: senderPos == null
                      ? CardDet(
                          RouteMenu("Pick From Location"),
                        )
                      : CardDet(RouteMenu(senderPos))),
              GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationPicker(pageCategory: "furniture",)));
                    if (result != null) {
                      setState(() {
                        receiverPos = result[1];
                      });
                    }
                  },
                  child: receiverPos == null
                      ? CardDet(RouteMenu("Pick To Location"))
                      : CardDet(RouteMenu(receiverPos))),
              SizedBox(
                height: 10,
              ),
              Text("The capacity of apartment",
                  style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 8,
              ),
              RadioGroup<String>.builder(
                direction: Axis.horizontal,
                groupValue: value,
                onChanged: (v) => setState(() {
                  value = v;
                }),
                items: list,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Incoming cost :",
                  style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 10,
              ),
              CostRow(
                  150, "Carpenter", curbbenterFunction, initialValCarbenter),
              CostRow(150, "Electerian", electerican, initialValElecterian),
              CostRow(50, "Carton Packaging", cartoonPackageFun,
                  initialValCartonPackage),
              CostRow(
                  500, "Flat Package", flatPackageFunc, initialValFlatPackage)
            ],
          ),
        ),
      ),
    );
  }
}

class CardDet extends StatelessWidget {
  final Widget widget;
  CardDet(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(elevation: 10, child: widget),
    );
  }
}
