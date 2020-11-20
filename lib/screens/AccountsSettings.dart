import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hovo_design/screens/ReviewScreen.dart';
import 'package:hovo_design/widgets/ImageStackWid.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: ReviewMyClipper(),
            child: Stack(
              children: [
                ImageStackWid(
                  imageProvider: AssetImage("lib/assets/images/cameraIcon.png"),
                  pageLabel: "Account Settings",
                )
              ],
            ),
          ),
          Text("Islam Gohar",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: "Poppins-Bold",
              )),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favourites",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins-Bold",
                        fontSize: 19),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FavouriteSettingsRow(
                    place: "Home",
                    fontawesome: FaIcon(
                      FontAwesomeIcons.home,
                      color: Colors.lightBlue[300],
                      size: 30,
                    ),
                    favouriteLabel: "Maadi Street",
                  ),
                  Divider(),
                  FavouriteSettingsRow(
                    place: "Work",
                    fontawesome: FaIcon(
                      FontAwesomeIcons.briefcase,
                      color: Colors.lightBlue[300],
                      size: 30,
                    ),
                    favouriteLabel: "Messadak Street",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FavouriteSettingsRow extends StatelessWidget {
  final Widget fontawesome;
  final String favouriteLabel;
  final String place;
  const FavouriteSettingsRow({
    this.favouriteLabel,
    this.fontawesome,
    this.place,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            fontawesome,
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place),
                Text(
                  favouriteLabel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins-Bold",
                      fontSize: 16),
                ),
              ],
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Change"),
        )
      ],
    );
  }
}
