import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeHelper {
  DateTimeHelper._();

  static String formatDateTime({
    required DateTime dateTime,
    required String format,
    bool toUtc = true,
  }) {
    final formatter = DateFormat(format);
    return formatter.format(toUtc ? dateTime.toUtc() : dateTime);
  }

  static DateTime convertToTimezone(String timezone, DateTime time) {
    tz.initializeTimeZones();
    var location = tz.getLocation(timezone);
    return tz.TZDateTime.from(time, location);
  }

  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
