bool isValidEmail(String email) {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegex.hasMatch(email);
}

const emptyString = "EMPTY";
bool isEmpty(String string) {
  return string == emptyString;
}
