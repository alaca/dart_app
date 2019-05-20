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
  String _errorCode;
  bool _isLoading = false;
  bool _autovalidate = false;

  AuthProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  String get email => _email;
  String get password => _password;
  String get error => _getError();
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
      _errorCode = null;
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
      
    } catch (e) {

      _errorCode = e.code;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;

    }
  }

  Future<bool> createUserWithEmailAndPassword({String email, String password}) async {
    
    try {
      _errorCode = null;
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;

    } catch(e) {
      _errorCode = e.code;
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

    if (firebaseUser != null) {
      _user = firebaseUser;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }

    notifyListeners();
    
  }

  String _getError() {

    if (_errorCode == null) 
      return null;

    switch(_errorCode) {

      case 'ERROR_WEAK_PASSWORD':
        return 'Password should be at least 6 characters';

      case 'ERROR_INVALID_EMAIL':
        return 'Invalid email address';

      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'Email already in use';

      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
      case 'ERROR_INVALID_CREDENTIAL':
        return 'Wrong email or password';

      case 'ERROR_USER_DISABLED':
        return 'You are banned!';

      default:
        return  'Something went wrong';

    }

  }
  
}