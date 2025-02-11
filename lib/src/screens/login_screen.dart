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
  final _key = GlobalKey<ScaffoldState>();

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
        key: _key,
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
      onSaved: (value) => auth.email = value,
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
      onSaved: (value) => auth.password = value,
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

            _formKey.currentState.save();

            final status = await auth.signInWithEmailAndPassword(email: auth.email, password: auth.password);

            if ( status ) {
              Navigator.pushReplacementNamed(context, 'home');
            } else {
              _key.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  auth.error, 
                  textAlign: TextAlign.center
                )
              ));
            }

          } else {

            auth.isLoading = false;

            if (!auth.autovalidate)
              auth.autovalidate = true;
          }

          auth.isLoading = false;

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