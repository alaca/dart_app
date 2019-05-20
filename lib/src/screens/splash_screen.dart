import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, AuthProvider auth, _) {

        Future.delayed(Duration(seconds: 2), () async {

          switch (auth.status) {
            case Status.Unauthenticated:
            case Status.Authenticating:
              return Navigator.pushReplacementNamed(context, 'login');
            case Status.Authenticated:
              return Navigator.pushReplacementNamed(context, 'home');
          } 
          
        });

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: Center(child: _logoImage())
          ) 
        );

      }

    );

  }

  Widget _logoImage() {
    return Hero(
      tag: 'authTopStaticElements',
      child: Image.asset( 
        'assets/images/icon.png',
        width: 230.0,
        height: 230.0
      ),
    );
  }
  

}