import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hovo_design/widgets/routeMenu.dart';

class Furniture extends StatefulWidget {
  @override
  _FurnitureState createState() => _FurnitureState();
}

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
int totalCost = 0;

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
              color: Colors.red[800],
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Estimated Price :",
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
                    print("d");
                  },
                  child: Container(
                      child: Text(
                    "Confirm ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text("Filling Form"),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardDet(
                "From : ",
                RouteMenu("Pick From Location"),
              ),
              CardDet("To : ", RouteMenu("Pick To Location")),
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

class CostRow extends StatelessWidget {
  final int text;
  final String jobname;
  final Function operation;
  final int cost;
  CostRow(this.text, this.jobname, this.operation, this.cost);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$jobname ($text) :",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  operation(0);
                }),
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: Text(
                cost.toString(),
                style: TextStyle(fontSize: 15),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  operation(1);
                })
          ],
        )
      ],
    );
  }
}

class CardDet extends StatelessWidget {
  final String text;
  final Widget widget;
  CardDet(this.text, this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(elevation: 10, child: widget),
    );
  }
}
