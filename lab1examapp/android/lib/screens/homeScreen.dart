import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/examCard.dart';

class HomeScreen extends StatelessWidget {
  final List<Exam> exams;
  final String studentIndex;
  const HomeScreen({Key? key, required this.exams, required this.studentIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raspored za ispiti - $studentIndex'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(exam: exams[index]);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(label: Text('Vkupno ispiti: ${exams.length}')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
