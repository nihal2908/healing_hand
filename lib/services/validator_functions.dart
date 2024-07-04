String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (!value.contains('@gmail.com')) {
    return 'Enter a valid Email';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
    return 'Name should not contain special characters or numbers';
  }
  return null;
}

String? passwordValidator(String? value) {
  if(value == null || value.isEmpty){
    return 'This field is required';
  }
  else if (value.length < 8 || !RegExp(r'[A-Z]').hasMatch(value) || !RegExp(r'[a-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value) || !RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(value)) {
    return 'Invalid Password';
  }
  return null;
}
