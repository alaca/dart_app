import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {

  final String text;

  ErrorText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text, 
      textAlign: TextAlign.center
    );
  }

}