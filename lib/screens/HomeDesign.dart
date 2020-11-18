import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovo_design/screens/furniture.dart';
import 'package:hovo_design/widgets/animatedContainer.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class HomesDesign extends StatefulWidget {
  @override
  _HomesDesignState createState() => _HomesDesignState();
}

List<Map> myMap = [
  {"image": "lib/assets/images/1.5 ton.png", "name": "1.5 ton"},
  {"image": "lib/assets/images/1.5ton closed.png", "name": "1.5 ton closed"},
  {"image": "lib/assets/images/Bicycle.png", "name": "Bicycle"},
  {"image": "lib/assets/images/bolan.png", "name": "Bolan"},
  {"image": "lib/assets/images/jumbo closed.png", "name": "Jumbo Closed"},
  {"image": "lib/assets/images/Motorcycle.png", "name": "Motorcycle"},
  {"image": "lib/assets/images/ravi.png", "name": "Ravi"},
  {"image": "lib/assets/images/tricycle.png", "name": "Tricycle"},
  {"image": "lib/assets/images/winch.png", "name": "Winch"}
];

class _HomesDesignState extends State<HomesDesign>
    with TickerProviderStateMixin {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  AnimationController _animationController;
  AnimationController _animationControllerMap;
  Animation<double> _animationMoveUp;
  Animation<double> _animationMoveUpMap;
  Location _location = Location();
  LocationData currentLocation;
  Future getCurrentPos() async {
    currentLocation = await _location.getLocation();
  }

  Future _future;
  @override
  void initState() {
    _future = getCurrentPos();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationControllerMap =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationMoveUp = CurvedAnimation(
        curve: Interval(0.25, 0.90), parent: _animationController);
    _animationMoveUpMap = CurvedAnimation(
        curve: Interval(0.25, 0.90), parent: _animationControllerMap);
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationControllerMap.dispose();
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

  var showPickUploc = false;
  var showVechi = false;
  int curentIndex = 0;
  void updateIndex(int n) {
    setState(() {
      curentIndex = n;
    });
  }

  var searchBar = true;

  String wheretoADRESS = "Where to ?";
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
                        opacity: showVechi ? _animationController.value : 0.411,
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
                              zoom: 15),
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
                        top: showCurrentLoc ? 80 : 20,
                        right: 0,
                        child: Container(
                          width: Get.width,
                          child: Card(
                            elevation: 15,
                            child: searchBar
                                ? SearchMapPlaceWidget(
                                    icon: Icons.car_rental,
                                    hasClearButton: true,
                                    clearIcon: Icons.clear,
                                    location: LatLng(currentLocation.latitude,
                                        currentLocation.longitude),
                                    radius: 30000,
                                    placeType: PlaceType.address,
                                    placeholder: wheretoADRESS,
                                    strictBounds: true,
                                    apiKey:
                                        "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                                    language: "eg",
                                    onSelected: (Place place) async {
                                      final geolocation =
                                          await place.geolocation;

                                      // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                      setState(() {
                                        showPickUploc = true;
                                        showCurrentLoc = false;
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLng(
                                                geolocation.coordinates));
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLngBounds(
                                                geolocation.bounds, 0));
                                      });
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(wheretoADRESS),
                                        Icon(
                                          Icons.car_rental,
                                          color: Colors.blue[800],
                                        )
                                      ],
                                    )),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: InkWell(
                          onTap: () async {
                            var address = await Geocoder.local
                                .findAddressesFromCoordinates(new Coordinates(
                                    currentLocation.latitude,
                                    currentLocation.longitude));
                            var displayaddress = address.first;
                            setState(() {
                              searchBar = false;
                              showCurrentLoc = false;
                              wheretoADRESS = displayaddress.locality +
                                  " " +
                                  displayaddress.adminArea +
                                  " " +
                                  displayaddress.subAdminArea;
                            });
                            showPickUploc = true;
                            _controller.animateCamera(CameraUpdate.newLatLng(
                                LatLng(currentLocation.latitude,
                                    currentLocation.longitude)));
                          },
                          child: showCurrentLoc
                              ? Card(
                                  child: Container(
                                    width: Get.width,
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("From My Current location"),
                                          Icon(Icons.place_rounded,
                                              color: Colors.red)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      showPickUploc
                          ? Positioned(
                              top: 90,
                              right: 0,
                              child: Container(
                                width: Get.width,
                                child: Card(
                                  elevation: 15,
                                  child: SearchMapPlaceWidget(
                                    icon: Icons.location_on,
                                    hasClearButton: true,
                                    clearIcon: Icons.clear,
                                    location: LatLng(currentLocation.latitude,
                                        currentLocation.longitude),
                                    radius: 30000,
                                    placeType: PlaceType.address,
                                    placeholder: "Pick up location",
                                    strictBounds: true,
                                    apiKey:
                                        "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                                    language: "eg",
                                    onSelected: (Place place) async {
                                      final geolocation =
                                          await place.geolocation;

                                      print(geolocation.coordinates);

                                      _animationController.forward();
                                      // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                                      setState(() {
                                        showVechi = true;
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLng(
                                                geolocation.coordinates));
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLngBounds(
                                                geolocation.bounds, 0));
                                      });
                                    },
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
                                opacity: _animationMoveUp.value,
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
                                opacity: _animationMoveUp.value,
                                child: MapNavButton(
                                    Icons.shopping_bag, "Multi Item Shipment",
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
                                opacity: _animationMoveUp.value,
                                child: MapNavButton(
                                    Icons.scatter_plot, textSatelite, () {
                                  toggleSatelite();
                                }),
                              ),
                            )
                          : Container(),
                      showVechi
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Opacity(
                                opacity: _animationMoveUp.value,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        color: Colors.white.withOpacity(0.9)),
                                    height: 120,
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: ListView.builder(
                                      itemCount: myMap.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 16),
                                          padding: EdgeInsets.only(
                                              top: 10, right: 1),
                                          decoration: BoxDecoration(),
                                          child: InkWell(
                                            onTap: () {
                                              updateIndex(index);
                                            },
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(23),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Colors.blue[800]),
                                                    ),
                                                    Positioned(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image(
                                                          image: AssetImage(
                                                              myMap[index]
                                                                  ["image"]),
                                                          width: 55,
                                                          height: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(myMap[index]["name"],
                                                    style: TextStyle(
                                                        color:
                                                            index == curentIndex
                                                                ? Colors.blue
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                                Text("Price",
                                                    style: TextStyle(
                                                        color:
                                                            index == curentIndex
                                                                ? Colors.blue
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ),
                            )
                          : Container()
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
