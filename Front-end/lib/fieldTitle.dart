import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  FieldTitle(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
          // color: Colors.teal[50],
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
