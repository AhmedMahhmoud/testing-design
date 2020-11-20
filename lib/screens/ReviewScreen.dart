import 'package:flutter/material.dart';
import 'package:hovo_design/widgets/ImageStackWid.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var rating = 0.0;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: rating > 0
          ? FloatingActionButton(
              onPressed: () {},
              // ignore: missing_required_param
              child: Icon(Icons.arrow_forward),
            )
          : Container(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ReviewMyClipper(),
              child: ImageStackWid(
                pageLabel: "Your truck in place!",
                imageProvider: NetworkImage(
                    "https://pyxis.nymag.com/v1/imgs/4e5/1f7/a917c50e70a4c16bc35b9f0d8ce0352635-14-tom-cruise.rsocial.w1200.jpg"),
              ),
            ),
            Text(
              "Your driver",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Tom Cruise",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TripInformation(
                  informationName: "Time",
                  informationData: "15 min",
                ),
                TripInformation(
                  informationName: "Price",
                  informationData: "\$ 9,99",
                ),
                TripInformation(
                  informationName: "Distance",
                  informationData: "15 km",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Rate", style: TextStyle(color: Colors.grey)),
            Text(
              "How is your trip ?",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins-Bold",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SmoothStarRating(
              borderColor: Color(0xff4FE8F3),
              starCount: 5,
              size: 50,
              allowHalfRating: true,
              color: Colors.yellow[700],
              onRated: (rate) {
                setState(() {
                  rating = rate;
                });
              },
            ),
            Divider(),
            Text(
              "Additional Comment ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              cursorColor: Colors.black,
              maxLines: null,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 0)),
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  hintText: "Write your comments here"),
            ),
          ],
        ),
      ),
    );
  }
}

class TripInformation extends StatelessWidget {
  final String informationName;
  final String informationData;
  const TripInformation({
    this.informationData,
    this.informationName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          informationName,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          informationData,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }
}

class ReviewMyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(1, size.height - 140);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 140);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
