import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  TitleWidget(
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xff2D3047),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          // color: Colors.teal,
        ),
        width: MediaQuery.of(context).size.width < 800 ? 350 : 500,
        height: 100,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: Colors.teal,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal
              // fontFamily:
              ),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
