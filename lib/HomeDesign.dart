import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomesDesign extends StatefulWidget {
  @override
  _HomesDesignState createState() => _HomesDesignState();
}

class _HomesDesignState extends State<HomesDesign> {
  LocationData currentLoc;

  LatLng _initialcameraposition;
  GoogleMapController _controller;
  Location _location;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  void setCurrentLoc() async {
    currentLoc = await _location.getLocation();
  }

  @override
  void initState() {
    Geolocator().getCurrentPosition().then((value) {
      setState(() {
        _initialcameraposition = LatLng(value.latitude, value.longitude);
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
            Positioned(
                right: 0,
                bottom: 400,
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(child: Text("First page")),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                )),
            Positioned(
                right: 0,
                bottom: 340,
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(child: Text("Second page")),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
