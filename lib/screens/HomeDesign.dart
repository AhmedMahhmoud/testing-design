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
  {
    "image":
        "https://i.pinimg.com/564x/71/e6/a9/71e6a94a9351c0a28a2c07a36e7cf04c.jpg",
    "name": "Truck"
  },
  {
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRYoy4nMLwfQ42zsV1LXmWYSgdLuJiaLM_SUQ&usqp=CAU",
    "name": "Motorcycle"
  },
  {
    "image":
        "https://i.pinimg.com/564x/71/e6/a9/71e6a94a9351c0a28a2c07a36e7cf04c.jpg",
    "name": "Truck"
  }
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
                    mapType: MapType.normal,
                    compassEnabled: true,
                    trafficEnabled: true,
                    myLocationEnabled: true,
                  ),
                  Positioned(
                    top: 40,
                    right: 12,
                    child: SearchMapPlaceWidget(
                      hasClearButton: true,
                      location: LatLng(currentLocation.latitude,currentLocation.longitude),
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
                  DropdownButtonHideUnderline(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 200,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: DropdownButton<String>(
                            hint: Text("Vechile"),
                            isDense: true,
                            elevation: 2,
                            isExpanded: true,
                            onChanged: (value) {},
                            items: myMap.map((Map e) {
                              return new DropdownMenuItem<String>(
                                  child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image(
                                        image: NetworkImage(e["image"]),
                                        width: 65,
                                        height: 50,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        e["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                            }).toList()),
                      ),
                    ),
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
