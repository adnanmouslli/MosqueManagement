import 'package:flutter/material.dart';

extension GradeExtension on double {
  String getGrade() {
    if (this >= 90) {
      return "A+";
    } else if (this >= 85) {
      return "A";
    } else if (this >= 80) {
      return "A-";
    } else if (this >= 75) {
      return "B+";
    } else if (this >= 70) {
      return "B";
    } else if (this >= 65) {
      return "B-";
    } else if (this >= 60) {
      return "C+";
    } else if (this >= 55) {
      return "C";
    } else if (this >= 50) {
      return "C-";
    } else if (this >= 45) {
      return "D+";
    } else if (this >= 40) {
      return "D";
    } else {
      return "F";
    }
  }

}
extension GradeColor on double {
  Color getColorForGrade() {
    if (this >= 90) {
      return Colors.green;
    } else if (this >= 85) {
      return Colors.lightGreen;
    } else if (this >= 80) {
      return Colors.yellow;
    } else if (this >= 75) {
      return Colors.orange;
    } else if (this >= 70) {
      return Colors.deepOrange;
    } else if (this >= 65) {
      return Colors.redAccent;
    } else if (this >= 60) {
      return Colors.red;
    } else if (this >= 55) {
      return Colors.deepPurple;
    } else if (this >= 50) {
      return Colors.purple;
    } else if (this >= 45) {
      return Colors.blue;
    } else if (this >= 40) {
      return Colors.cyan;
    } else {
      return Colors.grey;
    }
  }
}
