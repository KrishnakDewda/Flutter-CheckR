import 'package:intl/intl.dart';

class CheckrUtils {
  CheckrUtils._();

  static String toDateStringFormat(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static bool isEmailValid(String? email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return email != null ? regex.hasMatch(email) : false;
  }
}
