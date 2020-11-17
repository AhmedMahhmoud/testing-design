import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CostRow extends StatelessWidget {
  final int text;
  final String jobname;
  final Function operation;
  final int cost;
  CostRow(this.text, this.jobname, this.operation, this.cost);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$jobname ($text) :",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  operation(0);
                }),
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: Text(
                cost.toString(),
                style: TextStyle(fontSize: 15),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  operation(1);
                })
          ],
        )
      ],
    );
  }
}