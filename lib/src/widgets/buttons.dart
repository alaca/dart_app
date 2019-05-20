import 'package:flutter/material.dart';
import 'package:itrak2/src/providers/auth_provider.dart';

class AuthScreenRaisedButton extends StatelessWidget {

  final String title;
  final Function onPressed;

  AuthScreenRaisedButton({@required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        this.title,
        style: TextStyle(fontSize: 18.0) 
      ),
      color: Color(0xffffcc00),
      textColor: Colors.black,
      disabledColor: Colors.white30,
      padding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: this.onPressed
    );
  }

}
