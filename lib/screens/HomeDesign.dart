import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

class _HomesDesignState extends State<HomesDesign> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  LocationData currentLocation;
  Future getCurrentPos() async {
    currentLocation = await _location.getLocation();
  }

  Future _future;
  @override
  void initState() {
    _future = getCurrentPos();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
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
                  GoogleMap(
                    onMapCreated: (GoogleMapController c) {
                      setState(() {
                        _controller = c;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 15),
                    mapType: showSatalite ? MapType.satellite : MapType.normal,
                    compassEnabled: false,
                    myLocationButtonEnabled: true,
                    padding: EdgeInsets.only(top: 450),
                    trafficEnabled: true,
                    myLocationEnabled: true,
                  ),
                  Positioned(
                    top: 40,
                    right: 12,
                    child: SearchMapPlaceWidget(
                      hasClearButton: true,
                      location: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      radius: 30000,
                      placeType: PlaceType.address,
                      placeholder: "Search by location",
                      strictBounds: true,
                      apiKey: "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                      language: "eg",
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;

                        print(geolocation.coordinates);
                        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                        setState(() {
                          _controller.animateCamera(
                              CameraUpdate.newLatLng(geolocation.coordinates));
                          _controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  geolocation.bounds, 0));
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 400,
                    child: MapNavButton(
                        Icons.local_shipping, "Single Item Shipment", () {}),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 320,
                    child: MapNavButton(
                        Icons.shopping_bag, "Multi Item Shipment", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Furniture(),
                          ));
                    }),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 250,
                    child: MapNavButton(Icons.scatter_plot, textSatelite, () {
                      toggleSatelite();
                    }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            color: Colors.white.withOpacity(0.9)),
                        height: 100,
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: ListView.builder(
                          itemCount: myMap.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(23),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue[800]),
                                      ),
                                      Positioned(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image(
                                            image: AssetImage(
                                                myMap[index]["image"]),
                                            width: 55,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Text(myMap[index]["name"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic)))
                                ],
                              ),
                            );
                          },
                        )),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
