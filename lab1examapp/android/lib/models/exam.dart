import 'package:flutter/material.dart';
import '../models/exam.dart';

class Exam {
  final String subjectName;
  final DateTime dateTime;
  final List<String> rooms;
  Exam({
    required this.subjectName,
    required this.dateTime,
    required this.rooms,
  });
  bool get isPast => dateTime.isBefore(DateTime.now());
  String get formattedDate =>
      '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
  String get formattedTime =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  String get roomsString => rooms.join(', ');
  String get timeRemaining {
    final now = DateTime.now();
    Duration diff = dateTime.difference(now);
    bool past = diff.isNegative;
    if (past) diff = now.difference(dateTime);
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final prefix = past ? 'Ispitot bese pred: ' : 'Do ispitot ostanuva: ';
    return '$prefix${days} dena, ${hours} casa';
  }
}
