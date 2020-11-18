import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class LocationPicker extends StatefulWidget {
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
        backgroundColor: Colors.white,
        title: Text(
          "Pick The Location",
          style: TextStyle(
              color: Color(0xff3D4665),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        actions: [
          InkWell(
              onTap: () {
                if (location != null)
                  Navigator.of(context).pop(location);
                else
                  Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          print(location);
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
                      placeType: PlaceType.address,
                      placeholder: "Search certain location",
                      strictBounds: true,
                      apiKey: "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE",
                      language: "eg",
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;

                        print(geolocation.coordinates);
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
