import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapNavButton extends StatefulWidget {
  final String label;
  final IconData iconData;
  final Function onTap;
  MapNavButton(this.iconData, this.label, this.onTap);
  @override
  _MapNavButtonState createState() => _MapNavButtonState();
}

class _MapNavButtonState extends State<MapNavButton> {
  bool _folded = true;
  @override
  Widget build(BuildContext context) {
    var singleChildScrollView = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: !_folded
            ? InkWell(
                onTap: widget.onTap,
                child: Text(widget.label,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              )
            : null,
      ),
    );
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: _folded ? 56 : 190,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: kElevationToShadow[3],
      ),
      child: Row(
        children: [
          Expanded(child: singleChildScrollView),
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 25 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 25 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _folded ? widget.iconData : Icons.close,
                    color: Colors.blue[900],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
