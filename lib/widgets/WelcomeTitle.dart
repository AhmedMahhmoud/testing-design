
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({
    Key key,
    @required this.direction,
  }) : super(key: key);

  final String direction;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          width: Get.width-8,
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image(
                  image: NetworkImage(
                      "https://scontent.fcai21-2.fna.fbcdn.net/v/t1.0-9/117930429_2776344645799822_4892531859938386125_n.jpg?_nc_cat=106&ccb=2&_nc_sid=174925&_nc_ohc=WG30RXhubV0AX-6CPiD&_nc_ht=scontent.fcai21-2.fna&oh=f61cf06b0e6c70b9794cef55fcc01a24&oe=5FDC967C"),
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text("Hello, Ahmed"),
                  Text(
                    "Where is the $direction point ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins-Bold",
                        fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

class VechilesWidget extends StatelessWidget {
  final String vechName;
  final Color boxshadowColor;
  final Color color;
  final String vechImage;
  const VechilesWidget({
    this.vechImage,
    this.boxshadowColor,
    this.color,
    this.vechName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vechName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "\$ 9.90",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
              Text(
                "3 min",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w100,
                    fontSize: 17),
              )
            ],
          ),
          Image(
            width: 100,
            height: 100,
            fit: BoxFit.fitWidth,
            image: AssetImage(vechImage),
          )
        ],
      ),
      padding: EdgeInsets.only(left: 0, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: boxshadowColor,
            spreadRadius: 1,
            blurRadius: 7.0,
            offset: Offset(2, 4))
      ], color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}
