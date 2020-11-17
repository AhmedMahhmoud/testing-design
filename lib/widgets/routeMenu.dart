import 'package:flutter/material.dart';
import 'package:hovo_design/widgets/locatinPicker.dart';

class RouteMenu extends StatelessWidget {
  final String text;
  RouteMenu(this.text);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationPicker(),
            ));
      },
      child: Container(
          child: Center(
        child: (Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
      )),
    );
  }
}
