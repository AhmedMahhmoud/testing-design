import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String mainCity;
  final String insideCity;
  const RideCard({
    this.insideCity,
    this.mainCity,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "To  ",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              mainCity,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        Row(
          children: [
            Text(insideCity,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          width: 200,
          color: Colors.grey.withOpacity(0.2),
          height: 1,
        )
      ],
    );
  }
}
