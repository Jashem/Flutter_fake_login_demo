import 'package:flutter/material.dart';

Widget buildSnackBar({
  @required String message,
  @required Color color,
}) {
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
  );
}
