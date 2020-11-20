import 'package:flutter/material.dart';

class ImageStackWid extends StatelessWidget {
  final String pageLabel;
  final ImageProvider imageProvider;
  const ImageStackWid({
    this.imageProvider,
    this.pageLabel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 400, decoration: BoxDecoration(color: Color(0xFF009FFD))),
        Positioned(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                pageLabel,
                style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 23),
              ),
            ),
          ),
        ),
        Positioned(
            child: Center(
          child: Opacity(
            opacity: 0.1,
            child: Image(
                height: 400,
                fit: BoxFit.fitHeight,
                image: AssetImage("lib/assets/images/Routes.jpg")),
          ),
        )),
        Positioned(
            child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
              height: 200,
            ),
          ),
        ))
      ],
    );
  }
}
