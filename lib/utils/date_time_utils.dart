import 'package:intl/intl.dart';

String roundToNearest30(DateTime dateTime) {
  int minute = dateTime.minute;

  // If minutes are less than 30, round down to 30
  if (minute <= 30) {
    minute = 30;
  } else {
    minute = 0;
    dateTime = dateTime.add(
      const Duration(hours: 1),
    );
  }

  DateTime roundedDateTime = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    minute,
    00,
  );

  DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm");
  return formatter.format(roundedDateTime);
}
