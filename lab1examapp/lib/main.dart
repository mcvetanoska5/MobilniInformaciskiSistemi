import 'package:flutter/material.dart';
import 'models/exam.dart';
import 'screens/homeScreen.dart';

void main() {
  runApp(const ExamApp());
}
class ExamApp extends StatelessWidget {
  const ExamApp({Key? key}) : super(key: key);
  static const String studentIndex = '223109';
  List<Exam> _loadExams() {
    final exams = <Exam>[
      Exam(subjectName: 'Napreden veb dizajn', dateTime: DateTime(2025, 11, 15, 9, 0), rooms: ['Lab200v']),
      Exam(subjectName: 'Strukturno programiranje', dateTime: DateTime(2025, 11, 20, 14, 0), rooms: ['Lab215', 'Lab138']),
      Exam(subjectName: 'Voved vo nauka za podatoci', dateTime: DateTime(2025, 10, 10, 10, 0), rooms: ['Lab138']),
      Exam(subjectName: 'Fizika', dateTime: DateTime(2025, 12, 2, 8, 30), rooms: ['Lab3']),
      Exam(subjectName: 'Algoritmi i podatocni strukturi', dateTime: DateTime(2025, 11, 25, 11, 0), rooms: ['Lab117']),
      Exam(subjectName: 'Bazi na podatoci', dateTime: DateTime(2025, 9, 30, 13, 30), rooms: ['Lab200ab']),
      Exam(subjectName: 'Operativni sistemi', dateTime: DateTime(2026, 1, 10, 9, 0), rooms: ['Lab215']),
      Exam(subjectName: 'Kompjuterski mrezi', dateTime: DateTime(2025, 11, 11, 16, 0), rooms: ['Lab2']),
      Exam(subjectName: 'Softversko inzenerstvo', dateTime: DateTime(2025, 11, 5, 12, 0), rooms: ['AMF FINKI']),
      Exam(subjectName: 'Vestacka inteligencija', dateTime: DateTime(2025, 12, 20, 15, 0), rooms: ['Baraka 2.2']),
    ];
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return exams;
  }
  @override
  Widget build(BuildContext context) {
    final exams = _loadExams();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raspored za ispiti',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(exams: exams, studentIndex: studentIndex),
    );
  }
}
