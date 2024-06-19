bool validateEmail(String value) {
  // Regular expression for email validation
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(emailPattern);
  if (!regExp.hasMatch(value)) {
    return true;
  }
  return false;
}
