import 'package:fluttertoast/fluttertoast.dart';

showToast(String message,
    {double fontSize = 16.0, int timeInSecForIosWeb = 2, int androidTime = 5}) {
  Fluttertoast.showToast(
    msg: message,
    // gravity: ToastGravity.CENTER,
    toastLength: androidTime == 5
        ? Toast.LENGTH_LONG
        : Toast.LENGTH_SHORT, // short for 1 second
    fontSize: fontSize,
    timeInSecForIosWeb: timeInSecForIosWeb,
  );
}