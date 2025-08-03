import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Miscellaneous {
  static const String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String getInitials(String fullName) {
    List<String> names = fullName.split(' ');

    if (names.length > 2) {
      names.removeAt(1);
      String initials = names.map((name) => name.isNotEmpty ? name[0] : '').join('');
      return initials.toUpperCase(); // Convert to uppercase
    } else {
      String initials = names.map((name) => name.isNotEmpty ? name[0] : '').join('');
      return initials.toUpperCase(); // Convert to uppercase
    }
  }

  static Color setColor(String color) {
    String intColor = color.replaceAll("#", "");
    Color myColor = Color(int.parse("0xFF$intColor"));
    return myColor;
  }

  static String dateConverterWithDay(String date) {
    if (date.isNotEmpty) {
      DateTime dateTime = DateTime.parse(date);

      return DateFormat('EEEE, MMM d, yyyy hh:mm a').format(dateTime);
    } else {
      return "";
    }
  }

  static String dateConverterToYYYYMMDD(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateConverterToDDMMMYYYY(String date) {
    if(date.isEmpty){
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
  static String dateConverterToDDMMMYYYYHHMM(String date) {
    if(date.isEmpty){
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy HH:mm:ss').format(dateTime);
  }

  static String getDateWithTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String getTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('hh:mm').format(dateTime);
  }

  static num convertToMb(num value) {
    return value / (1024 * 1024);
  }

  static String convertTo12HourFormat(TimeOfDay time24) {
    DateTime dateTime = DateTime(0, 1, 1, time24.hour, time24.minute);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  static String convertTimeOfDayToUtc(TimeOfDay? timeOfDay) {
    // Convert directly to formatted string
    return "${timeOfDay?.hour.toString().padLeft(2, '0')}:"
        "${timeOfDay?.minute.toString().padLeft(2, '0')}:"
        "00"; // Seconds default to 00
  }
}
