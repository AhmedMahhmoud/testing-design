import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LocationData currentLocation;
  LatLng location;
  Future getCurrentPos() async {
    Location _location = Location();

    currentLocation = await _location.getLocation();
  }

  Future _future;
  @override
  void initState() {
    _future = getCurrentPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return GoogleMap(
                  markers: {
                    Marker(markerId: MarkerId('m1'), position: location)
                  },
                  onTap: (latLng) {
                    setState(() {
                      location = latLng;
                      print(location.latitude);
                    });
                  },
                  minMaxZoomPreference: MinMaxZoomPreference(16, 30),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation.latitude,
                          currentLocation.longitude)));
            }
          }),
    );
  }
}
