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


Future<Widget> signOutButton(BuildContext context, AuthProvider auth) {

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out?'),
        content: Text('Sign out from application?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        actions: <Widget>[
          FlatButton(
            child: Text('YES'),
            textColor: Color(0xffffcc00),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('NO'),
            textColor: Color(0xffffcc00),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
  );
}