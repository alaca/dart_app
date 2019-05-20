import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {

  final String text;

  ErrorText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Text(
        this.text, 
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red
        )
      )
    );
  }

}