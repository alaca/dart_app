class AuthValidators {

  String validateEmail(String email) {
    bool isValidEmail = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email); 
    return !isValidEmail ? 'Enter valid email' : null;
  }

  String validatePassword(String password) {
    return (password.length <= 3) ? 'Password must be at least 6 characters' : null;
  }

}