import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovo_design/screens/furniture.dart';
import 'package:hovo_design/widgets/VechilesListView.dart';
import 'package:hovo_design/widgets/WelcomeTitle.dart';
import 'package:hovo_design/widgets/animatedContainer.dart';
import 'package:hovo_design/widgets/locatinPicker.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class HomesDesign extends StatefulWidget {
  @override
  _HomesDesignState createState() => _HomesDesignState();
}

class _HomesDesignState extends State<HomesDesign>
    with TickerProviderStateMixin {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  AnimationController _animationController;

  Animation<double> _buttonIn;
  Animation<double> mapIN;
  Location _location = Location();
  LocationData currentLocation;
  Future getCurrentPos() async {
    currentLocation = await _location.getLocation();
  }

  Future _future;
  @override
  void initState() {
    _future = getCurrentPos();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0,
    );

    _buttonIn = CurvedAnimation(
        curve: Interval(0.20, 0.65), parent: _animationController);
    mapIN = CurvedAnimation(
        curve: Interval(0.0, 0.90), parent: _animationController);
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  var textSatelite = "Change To Satelite Map";
  var showSatalite = false;
  void toggleSatelite() {
    if (showSatalite == false)
      setState(() {
        showSatalite = true;
        textSatelite = "Change To Normal Map";
      });
    else {
      setState(() {
        showSatalite = false;
        textSatelite = "Change To Satelite Map";
      });
    }
  }

  var dropOffLocation;
  var pickUpLocation;
  var showPickUploc = false;
  var showVechi = false;
  int curentIndex = 0;

  var searchBar = true;
  var showWelcomeMessage = true;
  var direction = "pickup";
  String pickUpText = "Pick From Map";
  String dropOffText = "Pick drop of From Map";
  var showCurrentLoc = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity:
                            showVechi ? _animationController.value : 0.3999,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController c) {
                            setState(() {
                              _controller = c;
                            });
                          },
                          // onCameraMove: (position) {
                          //   print(position.target);
                          // },

                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentLocation.latitude,
                                  currentLocation.longitude),
                              zoom: 19),
                          mapType:
                              showSatalite ? MapType.satellite : MapType.normal,
                          compassEnabled: false,
                          myLocationButtonEnabled: true,
                          padding: EdgeInsets.only(top: 520),
                          trafficEnabled: true,
                          myLocationEnabled: true,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: showVechi
                            ? Container()
                            : Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                shadowColor: Colors.blue,
                                elevation: 2,
                                child: InkWell(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationPicker(
                                                  pageCategory: "home",
                                                )));
                                    if (result != null) {
                                      print(result);
                                      direction == "pickup"
                                          ? setState(() {
                                              pickUpLocation = result[0];
                                              pickUpText = result[1];

                                              _controller.animateCamera(
                                                  CameraUpdate.newLatLng(LatLng(
                                                      result[0].latitude,
                                                      result[0].longitude)));

                                              direction = "drop off";
                                              showPickUploc = true;
                                              _animationController.forward();
                                            })
                                          : setState(() {
                                              dropOffLocation = result[0];
                                              dropOffText = result[1];
                                              showWelcomeMessage = false;
                                              showVechi = true;
                                              _animationController.forward(
                                                  from: 0);
                                            });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.all(15),
                                    width: Get.width / 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Add Home",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(
                                          Icons.house,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                      Positioned(
                        top: 100,
                        right: 0,
                        child: showVechi
                            ? Container()
                            : Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                shadowColor: Colors.blue,
                                elevation: 3,
                                child: InkWell(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationPicker(
                                                  pageCategory: "work",
                                                )));
                                    if (result != null) {
                                      direction == "drop off"
                                          ? setState(() {
                                              dropOffLocation = result[0];
                                              dropOffText = result[1];
                                              showWelcomeMessage = false;
                                              showVechi = true;
                                              _animationController.forward(
                                                  from: 0);
                                              // showCurrentLoc = false;
                                            })
                                          : setState(() {
                                              pickUpLocation = result[0];
                                              pickUpText = result[1];
                                              direction = "drop off";
                                              showPickUploc = true;
                                              _controller.animateCamera(
                                                  CameraUpdate.newLatLng(LatLng(
                                                      result[0].latitude,
                                                      result[0].longitude)));

                                              _animationController.forward();
                                              // showCurrentLoc = false;
                                            });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.all(15),
                                    width: Get.width / 2.1,
                                    child: Column(
                                      children: [
                                        Text("Add Work"),
                                        Icon(
                                          Icons.work,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                      Positioned(
                        top: showVechi
                            ? 175 - 160 * _animationController.value
                            : 176,
                        right: 0,
                        child: Container(
                          width: Get.width,
                          child: Card(
                            elevation: 15,
                            child: searchBar
                                ? Container(
                                    child: SearchMapPlaceWidget(
                                      icon: Icons.location_on,
                                      iconColor: Colors.red,
                                      hasClearButton: true,
                                      clearIcon: Icons.clear,
                                      location: LatLng(currentLocation.latitude,
                                          currentLocation.longitude),
                                      radius: 10000,
                                      placeholder: pickUpText,
                                      apiKey:
                                          "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                                      language: "eg",
                                      onSelected: (Place place) async {
                                        final geolocation =
                                            await place.geolocation;
                                        pickUpLocation =
                                            geolocation.coordinates;
                                        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                        setState(() {
                                          direction = "drop off";
                                          showPickUploc = true;
                                          _animationController.forward(from: 0);

                                          // showCurrentLoc = false;
                                          _controller.animateCamera(
                                              CameraUpdate.newLatLng(
                                                  geolocation.coordinates));
                                          _controller.animateCamera(
                                              CameraUpdate.newLatLngBounds(
                                                  geolocation.bounds, 0));
                                        });
                                      },
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        child: showWelcomeMessage
                            ? WelcomeTitle(direction: direction)
                            : Container(),
                      ),
                      showPickUploc
                          ? Positioned(
                              top: showVechi
                                  ? 235 - 160 * _animationController.value
                                  : 235,
                              right: 0,
                              child: Opacity(
                                opacity: _buttonIn.value,
                                child: Container(
                                  width: Get.width,
                                  child: Card(
                                    elevation: 15,
                                    child: SearchMapPlaceWidget(
                                      icon: Icons.car_rental,
                                      iconColor: Colors.red,
                                      hasClearButton: true,
                                      clearIcon: Icons.clear,
                                      location: LatLng(currentLocation.latitude,
                                          currentLocation.longitude),
                                      radius: 10000,
                                      placeholder: dropOffText,
                                      apiKey:
                                          "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                                      language: "eg",
                                      onSelected: (Place place) async {
                                        final geolocation =
                                            await place.geolocation;

                                        dropOffLocation =
                                            geolocation.coordinates;

                                        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                        setState(() {
                                          showWelcomeMessage = false;
                                          showVechi = true;
                                          _controller.animateCamera(
                                              CameraUpdate.newLatLng(
                                                  geolocation.coordinates));
                                          _controller.animateCamera(
                                              CameraUpdate.newLatLngBounds(
                                                  geolocation.bounds, 0));
                                        });
                                        _animationController.forward(from: 0);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      showVechi
                          ? Positioned(
                              right: 0,
                              bottom: 400,
                              child: Opacity(
                                opacity: _animationController.value,
                                child: MapNavButton(Icons.local_shipping,
                                    "Single Item Shipment", () {}),
                              ),
                            )
                          : Container(),
                      showVechi
                          ? Positioned(
                              right: 0,
                              bottom: 320,
                              child: Opacity(
                                opacity: _animationController.value,
                                child: MapNavButton(
                                    Icons.shopping_bag, "Furniture Shipping",
                                    () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Furniture(),
                                      ));
                                }),
                              ),
                            )
                          : Container(),
                      showVechi
                          ? Positioned(
                              right: 0,
                              bottom: 250,
                              child: Opacity(
                                opacity: _animationController.value,
                                child: MapNavButton(
                                    Icons.scatter_plot, textSatelite, () {
                                  toggleSatelite();
                                }),
                              ),
                            )
                          : Container(),
                      showVechi ? Vechiles() : Container()
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
