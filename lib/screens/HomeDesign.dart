import 'dart:async';

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovo_design/screens/VerificationCodeScreen.dart';
import 'package:hovo_design/screens/furniture.dart';
import 'package:hovo_design/widgets/VechilesListView.dart';
import 'package:hovo_design/widgets/WelcomeTitle.dart';
import 'package:hovo_design/widgets/animatedContainer.dart';
import 'package:hovo_design/widgets/locatinPicker.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

const double CAMERA_ZOOM = 12;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

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

  Completer<GoogleMapController> _completerController = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE";
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves

// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;
  Future _future;
  void setSourceAndDestinationIcons() async {
    try {
      sourceIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          "lib/assets/images/driving_pin.png");
      destinationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          "lib/assets/images/destination_map_marker.png");
    } catch (e) {
      print(e);
    }
  }

  // void updatePinOnMap() async {
  //   // create a new CameraPosition instance
  //   // every time the location changes, so the camera
  //   // follows the pin as it moves with an animation
  //   CameraPosition cPosition = CameraPosition(
  //     zoom: CAMERA_ZOOM,
  //     tilt: CAMERA_TILT,
  //     bearing: CAMERA_BEARING,
  //     target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //   );
  //   final GoogleMapController controller = await _completerController.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  //   // do this inside the setState() so Flutter gets notified
  //   // that a widget update is due
  //   setState(() {
  //     // updated position
  //     var pinPosition =
  //         LatLng(currentLocation.latitude, currentLocation.longitude);

  //     // the trick is to remove the marker (by id)
  //     // and add it again at the updated location
  //     _markers.removeWhere((m) => m.markerId.value == "sourcePin");
  //     _markers.add(Marker(
  //         markerId: MarkerId("sourcePin"),
  //         position: pinPosition, // updated position
  //         icon: sourceIcon));
  //   });
  // }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId("destPin"),
          position: dropOffLocation,
          icon: destinationIcon));
    });
  }

  void showPinsOnMap() async {
    try {
      // get a LatLng for the source location
      // from the LocationData currentLocation object
      var pinPosition =
          LatLng(pickUpLocation.latitude, pickUpLocation.longitude);
      // get a LatLng out of the LocationData object
      var destPosition =
          LatLng(dropOffLocation.latitude, dropOffLocation.longitude);
      // add the initial source location pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destPosition,
          icon: destinationIcon));
      // set the route lines on the map from source to destination
      // for more info follow this tutorial
      setPolylines();
    } catch (e) {
      print("show pins on map : ");
      print(e);
    }
  }

  void setPolylines() async {
    try {
      polylineCoordinates.clear();
      List<PointLatLng> result =
          await polylinePoints.getRouteBetweenCoordinates(
              googleAPIKey,
              pickUpLocation.latitude,
              pickUpLocation.longitude,
              dropOffLocation.latitude,
              dropOffLocation.longitude);
      if (result.isNotEmpty) {
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        setState(() {
          _polylines.add(Polyline(
              width: 5, // set the width of the polylines
              polylineId: PolylineId("poly"),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates));
        });
      }
    } catch (e) {
      print("set poly line : ");
      print(e);
    }
  }

  setInitialLocation() async {
    try {
      currentLocation = await location.getLocation();
      destinationLocation = LocationData.fromMap({
        "latitude": dropOffLocation.latitude,
        "longitude": dropOffLocation.longitude
      });
    } catch (e) {
      print("setInitialLocation : ");
      print(e);
    }
  }

  @override
  void initState() {
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event

    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,

      currentLocation = cLoc;

      setSourceAndDestinationIcons();
    }); // updatePinOnMap();
    // set custom marker pins   // set the initial location
    // setInitialLocation();

    // set the initial location
    setInitialLocation();
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

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    _animationController.dispose();
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
  var pickUpLocation = LatLng(42.7477863, -71.1699932);
  var showPickUploc = false;
  var showVechi = false;
  int curentIndex = 0;

  var searchBar = true;
  var showWelcomeMessage = true;
  var direction = "pickup";
  String pickUpText = "Pick From Map";
  String dropOffText = "Pick drop off From Map";
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
                return Stack(
                  children: [
                    Opacity(
                      opacity: showVechi ? _animationController.value : 0.3999,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController c) {
                          _completerController.complete(c);
                          //  setMapPins();
                          // setPolylines();

                          setState(() {
                            _controller = c;
                          });
                        },
                        // onCameraMove: (position) {
                        //   print(position.target);
                        // },

                        markers: _markers,
                        tiltGesturesEnabled: false, polylines: _polylines,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: CAMERA_ZOOM,
                            tilt: CAMERA_TILT,
                            bearing: CAMERA_BEARING),
                        mapType:
                            showSatalite ? MapType.satellite : MapType.normal,
                        compassEnabled: false,
                        myLocationButtonEnabled: true,
                        padding: EdgeInsets.only(top: 520),
                        trafficEnabled: false,
                        myLocationEnabled: true,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: showVechi
                          ? Container()
                          : FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {}
                                if (snapshot.hasData) {
                                  return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      shadowColor: Colors.blue,
                                      elevation: 2,
                                      child: InkWell(
                                        onTap: snapshot.data.data()["home"] ==
                                                ""
                                            ? () async {
                                                var result =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LocationPicker(
                                                                  pageCategory:
                                                                      "home",
                                                                )));
                                                if (result != null) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser.uid)
                                                      .update(
                                                    {
                                                      "home": result[1],
                                                      "homeLat": GeoPoint(
                                                          result[0].latitude,
                                                          result[0].longitude)
                                                    },
                                                  );

                                                  direction == "pickup"
                                                      ? setState(() {
                                                          pickUpLocation =
                                                              result[0];
                                                          pickUpText =
                                                              result[1];

                                                          direction =
                                                              "drop off";
                                                          showPickUploc = true;
                                                          _animationController
                                                              .forward();
                                                        })
                                                      : setState(() {
                                                          dropOffLocation =
                                                              result[0];

                                                          dropOffText =
                                                              result[1];
                                                          _controller.animateCamera(
                                                              CameraUpdate.newLatLng(LatLng(
                                                                  result[0]
                                                                      .latitude,
                                                                  result[0]
                                                                      .longitude)));
                                                          showWelcomeMessage =
                                                              false;
                                                          showVechi = true;
                                                          _animationController
                                                              .forward(from: 0);
                                                        });
                                                  showPinsOnMap();
                                                }
                                              }
                                            : direction == "pickup"
                                                ? () {
                                                    setState(() {
                                                      pickUpText = snapshot.data
                                                          .data()["home"];
                                                      showPickUploc = true;
                                                      pickUpLocation = LatLng(
                                                          snapshot.data
                                                              .data()["homeLat"]
                                                              .latitude,
                                                          snapshot.data
                                                              .data()["homeLat"]
                                                              .longitude);
                                                      direction = "drop off";
                                                      _animationController
                                                          .forward();
                                                    });
                                                  }
                                                : () {
                                                    setState(() {
                                                      dropOffText = snapshot
                                                          .data
                                                          .data()["home"];
                                                      showVechi = true;

                                                      dropOffLocation = LatLng(
                                                          snapshot.data
                                                              .data()["homeLat"]
                                                              .latitude,
                                                          snapshot.data
                                                              .data()["homeLat"]
                                                              .longitude);
                                                      showWelcomeMessage =
                                                          false;
                                                      _animationController
                                                          .forward(from: 0);
                                                      _controller.animateCamera(
                                                          CameraUpdate.newLatLng(LatLng(
                                                              snapshot.data
                                                                  .data()[
                                                                      "homeLat"]
                                                                      [0]
                                                                  .latitude,
                                                              snapshot.data
                                                                  .data()[
                                                                      "homeLat"]
                                                                      [0]
                                                                  .longitude)));
                                                      showPinsOnMap();
                                                    });
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Icon(
                                                Icons.house,
                                                color: Colors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                                return Container();
                              }),
                    ),
                    Positioned(
                      top: 100,
                      right: 0,
                      child: showVechi
                          ? Container()
                          : FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {}
                                if (snapshot.hasData) {
                                  return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      shadowColor: Colors.blue,
                                      elevation: 3,
                                      child: InkWell(
                                        onTap: snapshot.data.data()["work"] ==
                                                ""
                                            ? () async {
                                                var result =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LocationPicker(
                                                                  pageCategory:
                                                                      "work",
                                                                )));
                                                if (result != null) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser.uid)
                                                      .update(
                                                    {
                                                      "work": result[1],
                                                      "workLat": GeoPoint(
                                                          result[0].latitude,
                                                          result[0].longitude)
                                                    },
                                                  );
                                                  direction == "drop off"
                                                      ? setState(() {
                                                          dropOffLocation =
                                                              result[0];
                                                          showPinsOnMap();
                                                          dropOffText =
                                                              result[1];
                                                          showWelcomeMessage =
                                                              false;
                                                          showVechi = true;
                                                          _animationController
                                                              .forward(from: 0);
                                                          _controller.animateCamera(
                                                              CameraUpdate.newLatLng(LatLng(
                                                                  result
                                                                      .latitude,
                                                                  result
                                                                      .longitude)));
                                                          showPinsOnMap();
                                                          // showCurrentLoc = false;
                                                        })
                                                      : setState(() {
                                                          pickUpLocation =
                                                              result[0];
                                                          pickUpText =
                                                              result[1];
                                                          direction =
                                                              "drop off";
                                                          showPickUploc = true;

                                                          _animationController
                                                              .forward();
                                                          // showCurrentLoc = false;
                                                        });
                                                }
                                              }
                                            : direction == "pickup"
                                                ? () {
                                                    setState(() {
                                                      pickUpLocation = LatLng(
                                                          snapshot.data
                                                              .data()["workLat"]
                                                              .latitude,
                                                          snapshot.data
                                                              .data()["workLat"]
                                                              .longitude);

                                                      pickUpText = snapshot.data
                                                          .data()["work"];
                                                      direction = "drop off";
                                                      showPickUploc = true;
                                                      _animationController
                                                          .forward(from: 0);
                                                    });
                                                  }
                                                : () {
                                                    setState(() {
                                                      dropOffLocation = LatLng(
                                                          snapshot.data
                                                              .data()["workLat"]
                                                              .latitude,
                                                          snapshot.data
                                                              .data()["workLat"]
                                                              .longitude);
                                                      showPinsOnMap();
                                                      dropOffText = snapshot
                                                          .data
                                                          .data()["work"];
                                                      showWelcomeMessage =
                                                          false;
                                                      showVechi = true;
                                                      _controller.animateCamera(
                                                          CameraUpdate.newLatLng(LatLng(
                                                              snapshot.data
                                                                  .data()[
                                                                      "workLat"]
                                                                  .latitude,
                                                              snapshot.data
                                                                  .data()[
                                                                      "workLat"]
                                                                  .longitude)));
                                                      showPinsOnMap();
                                                      _animationController
                                                          .forward(from: 0);
                                                    });
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
                                      ));
                                }
                                return Container();
                              }),
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

                                      // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                      setState(() {
                                        pickUpLocation =
                                            geolocation.coordinates;
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLng(
                                                geolocation.coordinates));
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLngBounds(
                                                geolocation.bounds, 0));

                                        showPinsOnMap();

                                        direction = "drop off";
                                        showPickUploc = true;
                                        _animationController.forward(from: 0);

                                        // showCurrentLoc = false;
                                        // _controller.animateCamera(
                                        //     CameraUpdate.newLatLng(
                                        //         geolocation.coordinates));
                                        // _controller.animateCamera(
                                        //     CameraUpdate.newLatLngBounds(
                                        //         geolocation.bounds, 0));
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

                                      // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                      setState(() {
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLng(
                                                geolocation.coordinates));
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLngBounds(
                                                geolocation.bounds, 0));
                                        dropOffLocation =
                                            geolocation.coordinates;

                                        showWelcomeMessage = false;
                                        showVechi = true;
                                      });
                                      showPinsOnMap();
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
                                  Icons.shopping_bag, "Furniture Shipping", () {
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
                    showVechi
                        ? Opacity(
                            opacity: _animationController.value,
                            child: Vechiles())
                        : Container()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
