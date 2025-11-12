import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;
  const ExamDetailScreen({Key? key, required this.exam}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isPast = exam.isPast;
    return Scaffold(
      appBar: AppBar(title: Text(exam.subjectName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text(exam.formattedDate, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time),
                        const SizedBox(width: 8),
                        Text(exam.formattedTime, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.meeting_room),
                        const SizedBox(width: 8),
                        Expanded(child: Text(exam.roomsString, style: const TextStyle(fontSize: 16))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(exam.timeRemaining, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    if (isPast)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Ovoj ispit e pominat.', style: TextStyle(color: Colors.grey[700])),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
