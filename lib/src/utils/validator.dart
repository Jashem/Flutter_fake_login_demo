class Validateor {
  static String emailValidator(String value) {
    if (value.isEmpty ||
        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
      return 'Invalid email!';
    }
    return null;
  }

  static String passwordValidator(String value) {
    if (value.isEmpty || value.length < 5) {
      return 'Password is too short!';
    }
    return null;
  }

  static String emptyValidator(String value) {
    if (value.isEmpty) {
      return 'Field can not be empty!';
    }
    return null;
  }

  static String phoneValidator(String value) {
    print(int.tryParse(value));
    if (value.isEmpty) {
      return 'Field can not be empty';
    } else {
      if (value.length != 11 ||
          int.tryParse(value) == null ||
          int.tryParse(value).isNegative) {
        return 'Enter Valid Phone Number';
      } else {
        return null;
      }
    }
  }
}
