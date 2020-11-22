// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:location/location.dart';

// const double CAMERA_ZOOM = 16;
// const double CAMERA_TILT = 80;
// const double CAMERA_BEARING = 30;

// class TraceMap extends StatefulWidget {
  

//   @override
//   _TraceMapState createState() => _TraceMapState();
// }

// class _TraceMapState extends State<TraceMap> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = Set<Marker>();
// // for my drawn routes on the map
//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints;
//   String googleAPIKey = "AIzaSyCyt_eysLh70lE25053JEzJaTYsvrQGfRE";
// // for my custom marker pins
//   BitmapDescriptor sourceIcon;
//   BitmapDescriptor destinationIcon;
// // the user's initial location and current location
// // as it moves
//   LocationData currentLocation;
// // a reference to the destination location
//   LocationData destinationLocation;
// // wrapper around the location API
//   Location location;
//   @override
//   void initState() {
//     super.initState();

//     // create an instance of Location
//     location = new Location();
//     polylinePoints = PolylinePoints();

//     // subscribe to changes in the user's location
//     // by "listening" to the location's onLocationChanged event

//     location.onLocationChanged.listen((LocationData cLoc) {
//       // cLoc contains the lat and long of the
//       // current user's position in real time,

//       currentLocation = cLoc;
//         updatePinOnMap();
//     });
//     // set custom marker pins
//     setSourceAndDestinationIcons();
//     // set the initial location
//     setInitialLocation();
//   }

//   void setSourceAndDestinationIcons() async {
//     try {
//       sourceIcon = await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration(devicePixelRatio: 2.5),
//           "lib/assets/images/driving_pin.png");
//       destinationIcon = await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration(devicePixelRatio: 2.5),
//           "lib/assets/images/destination_map_marker.png");
//     } catch (e) {
//       print(e);
//     }
//   }

//   setInitialLocation() async {
//     try {
//       currentLocation = await location
//           .getLocation(); 
//       destinationLocation = LocationData.fromMap({
//         "latitude": widget.destinationLatLng.latitude,
//         "longitude": widget.destinationLatLng.longitude
//       });
//     } catch (e) {
//       print("setInitialLocation : ");
//       print(e);
//     }
//   }

//   void showPinsOnMap() async {
//     try {
//       currentLocation = await location
//           .getLocation(); // hard-coded destination for this example

//       destinationLocation = LocationData.fromMap({
//         "latitude": widget.destinationLatLng.latitude,
//         "longitude": widget.destinationLatLng.longitude
//       });

//       var pinPosition = widget.driverLatLng;

//       var destPosition = widget.destinationLatLng;

//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           position: pinPosition,
//           icon: sourceIcon));
//       // destination pin
//       _markers.add(Marker(
//           markerId: MarkerId('destPin'),
//           position: destPosition,
//           icon: destinationIcon));
//       // set the route lines on the map from source to destination

//       setPolylines();
//     } catch (e) {
//       print("show pins on map : ");
//       print(e);
//     }
//   }

//   void updatePinOnMap() async {
//     // create a new CameraPosition instance
//     // every time the location changes, so the camera
//     // follows the pin as it moves with an animation
//     CameraPosition cPosition = CameraPosition(
//       zoom: CAMERA_ZOOM,
//       tilt: CAMERA_TILT,
//       bearing: CAMERA_BEARING,
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//     );
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//     // do this inside the setState() so Flutter gets notified
//     // that a widget update is due
//     setState(() {
//       // updated position
//       var pinPosition =
//           LatLng(currentLocation.latitude, currentLocation.longitude);

//       // the trick is to remove the marker (by id)
//       // and add it again at the updated location
//       _markers.removeWhere((m) => m.markerId.value == "sourcePin");
//       _markers.add(Marker(
//           markerId: MarkerId("sourcePin"),
//           position: pinPosition, // updated position
//           icon: sourceIcon));
//     });
//   }

//   void setPolylines() async {
//     try {
//       List<PointLatLng> result =
//           await polylinePoints.getRouteBetweenCoordinates(
//               googleAPIKey,
//               currentLocation.latitude,
//               currentLocation.longitude,
//               destinationLocation.latitude,
//               destinationLocation.longitude);
//       if (result.isNotEmpty) {
//         result.forEach((PointLatLng point) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         });
//         setState(() {
//           _polylines.add(Polyline(
//               width: 5, // set the width of the polylines
//               polylineId: PolylineId("poly"),
//               color: Color.fromARGB(255, 40, 122, 198),
//               points: polylineCoordinates));
//         });
//       }
//     } catch (e) {
//       print("set poly line : ");
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialCameraPosition = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         tilt: CAMERA_TILT,
//         target: widget.driverLatLng,
//         bearing: CAMERA_BEARING);
//     if (currentLocation != null) {
//       initialCameraPosition = CameraPosition(
//           target: widget.driverLatLng,
//           zoom: CAMERA_ZOOM,
//           tilt: CAMERA_TILT,
//           bearing: CAMERA_BEARING);
//     }
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//               myLocationEnabled: true,
//               compassEnabled: true,
//               tiltGesturesEnabled: false,
//               markers: _markers,
//               polylines: _polylines,
//               mapType: MapType.normal,
//               trafficEnabled: true,
//               initialCameraPosition: initialCameraPosition,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);

//                 showPinsOnMap();
//               })
//         ],
//       ),
//     );
//   }
// }
