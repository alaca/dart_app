import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/buttons.dart';

class HomeScreen extends StatelessWidget {

  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('iTrak'),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:() => Consumer(
              builder: (context, AuthProvider auth, _) {
                signOutButton(context, auth);
              })
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
            Text('Logged in!!!!!!', style: TextStyle(
              color: Colors.white
            ))
          ],
        )
      ) 
    );

  }



}