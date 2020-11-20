import 'package:flutter/cupertino.dart';

class LogoStack extends StatelessWidget {
  const LogoStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 500, decoration: BoxDecoration(color: Color(0xFF009FFD))),
        Positioned(
            child: Center(
          child: Opacity(
            opacity: 0.1,
            child: Image(
                height: 500,
                fit: BoxFit.fitHeight,
                image: AssetImage("lib/assets/images/Routes.jpg")),
          ),
        )),
        Positioned(
            child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Image(
              image: AssetImage("lib/assets/images/hovo logo.png"),
              height: 200,
            ),
          ),
        ))
      ],
    );
  }
}
