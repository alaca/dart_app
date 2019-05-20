import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {

  Widget build(context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('iTrak'),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:() {

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
                        onPressed: () async {
                          await auth.signOut();
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, 'login');
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
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        )

      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60.0,
          left: 60.0,
          right: 60.0
        ),
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Logged in!', style: TextStyle(
              color: Colors.white
            ))
          ],
        )
      ) 
    );

  }



}