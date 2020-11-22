import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class LocationPicker extends StatefulWidget {
  final String pageCategory;
  LocationPicker({@required this.pageCategory});
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController _controller;
  LocationData currentLocation;
  LatLng location;
  Future getCurrentPos() async {
    Location _location = Location();

    currentLocation = await _location.getLocation();
  }

  Future _future;
  @override
  void initState() {
    super.initState();
    _future = getCurrentPos();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.pageCategory == "furniture"
                ? "Pick The Location"
                : widget.pageCategory == "home"
                    ? "Add your home Location"
                    : "Add your work location",
            style: TextStyle(
                color: Color(0xff3D4665),
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.left,
          ),
        ),
        actions: [
          InkWell(
              onTap: () async {
                if (location != null) {
                  List<dynamic> currentPositionList = [];
                  var address = await Geocoder.local
                      .findAddressesFromCoordinates(new Coordinates(
                          location.latitude, location.longitude));
                  var displayaddress = address.first;
                  var finalAddress = displayaddress.locality +
                      " " +
                      displayaddress.adminArea +
                      " " +
                      displayaddress.subAdminArea;
                  currentPositionList = [location, finalAddress];
                  print(currentPositionList[1]);
                  Navigator.of(context).pop(currentPositionList);
                } else
                  Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ))
        ],
      ),
      body: FutureBuilder(
          future: _future,
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else {
              if (location == null)
                location =
                    LatLng(currentLocation.latitude, currentLocation.longitude);
              return Stack(
                children: [
                  GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          _controller = controller;
                        });
                      },
                      markers: {
                        Marker(markerId: MarkerId('m1'), position: location)
                      },
                      onTap: (latLng) {
                        setState(() {
                          location = latLng;
                        });
                      },
                      minMaxZoomPreference: MinMaxZoomPreference(16, 30),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude,
                              currentLocation.longitude))),
                  Positioned(
                    top: 0,
                    child: SearchMapPlaceWidget(
                      hasClearButton: true,
                      location: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      radius: 30000,
                      placeholder: "Search certain location",
                      apiKey: "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                      language: "eg",
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;

                        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                        setState(() {
                          location = geolocation.coordinates;
                          _controller.animateCamera(
                              CameraUpdate.newLatLng(geolocation.coordinates));
                          _controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  geolocation.bounds, 0));
                        });
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
