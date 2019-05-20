import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_validators.dart';
export 'auth_validators.dart';


class AuthProvider with ChangeNotifier {

  String _email;
  String _password;
  String _error;
  bool _isLoading = false;
  bool _autovalidate = false;

  String get email => _email;
  String get password => _password;
  String get error => _error;
  bool get isLoading => _isLoading;
  bool get autovalidate => _autovalidate;

  FirebaseAuth get instance => FirebaseAuth.instance;
  Future<FirebaseUser> get currentUser => instance.currentUser();

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
 

  set autovalidate(bool value) {
    _autovalidate = value;
    notifyListeners();
  }

  
}