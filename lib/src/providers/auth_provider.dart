import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_validators.dart';
export 'auth_validators.dart';

enum Status { Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {

  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Unauthenticated;
  
  String _email;
  String _password;
  String _error;
  bool _isLoading = false;
  bool _autovalidate = false;

  AuthProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  String get email => _email;
  String get password => _password;
  String get error => _error;
  bool get isLoading => _isLoading;
  bool get autovalidate => _autovalidate;
  Status get status => _status;
  FirebaseUser get user => _user;

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

  Future<bool> signInWithEmailAndPassword({String email, String password}) async {
    try {

      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
      
    } catch (e) {

      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;

    }
  }

  Future<bool> createUserWithEmailAndPassword({String email, String password}) async {
    
    try {

      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;

    } catch(e) {

      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;

    }


  }

  Future<void> signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }


  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {

    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }

    notifyListeners();
  }

  
}