// used to validate email
bool emailAddressValidator(String value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (!emailValid) {
    return true;
  } else {
    return false;
  }
}

//check for minimum length
bool minLengthValidator(int minlength, String value) {
  if (value.length < minlength) {
    return true;
  } else {
    return false;
  }
}

//validate mobile number
bool mobileNumberValidator(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return true;
  }
  return false;
}
