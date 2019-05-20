import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/buttons.dart';
import '../decorations/text_fields.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AuthValidators {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    AuthProvider auth =  Provider.of<AuthProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: auth.isLoading,
      color: Colors.black,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: 70.0,
            left: 60.0,
            right: 60.0
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
            color: Colors.black
          ),
          child: Form(
            key: _formKey,
            autovalidate: auth.autovalidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'authTopStaticElements',
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        _logoImage(),
                        SizedBox(height: 20),
                        _emailField(auth),
                        SizedBox(height: 20),
                        _passwordField(auth),
                        SizedBox(height: 20)
                      ],
                    )
                  )
                ),
                _loginButton(context, auth),
                SizedBox(height: 70),
                _registerButton(context, auth)
              ],
            )
          )
        ) 
      )
    );

  }


  Widget _logoImage() {
    return Image.asset( 
      'assets/images/icon.png',
      width: 170.0,
      height: 170.0
    );
  }
  
  Widget _emailField(AuthProvider auth) {
    return TextFormField(
      validator: (email) => validateEmail(email),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      decoration: authScreenTextFieldDecoration.copyWith(
        hintText: 'email' 
      )
    );
  }

  Widget _passwordField(AuthProvider auth) {
    return TextFormField(
      validator: (password) => validatePassword(password),
      obscureText: true,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      decoration: authScreenTextFieldDecoration.copyWith(
        hintText: 'password',
      )
    );
  }

  Widget _loginButton(BuildContext context, AuthProvider auth) {

    return Hero(
      tag: 'loginButton',
      child: AuthScreenRaisedButton(
        title: 'Login',
        onPressed: () async {

          auth.isLoading = true;

          if (_formKey.currentState.validate()) {

            await Future.delayed(Duration(seconds: 3), () => auth.isLoading = false);  

          } else {

            auth.isLoading = false;

            if (!auth.autovalidate)
              auth.autovalidate = true;
          }

        }
      ),
    );
  }

  Widget _registerButton(BuildContext context, AuthProvider auth) {

    return Hero(
      tag: 'registerButton',
      child: AuthScreenRaisedButton(
        title: 'Register',
        onPressed: () => Navigator.pushNamed(context, 'register')
      ),
    );
  }

}