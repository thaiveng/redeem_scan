String? validationPhoneNumber(String? value) {
  value = value?.trim();

  if (value == "") {
    return "Please enter Phone Number";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == "") {
    return "Please enter your password";
  }
  return null;
}
