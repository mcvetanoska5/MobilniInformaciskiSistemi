import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../screens/examDetails.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  const ExamCard({Key? key, required this.exam}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = exam.isPast ? Colors.grey[200] : Colors.white;
    final sideColor = exam.isPast ? Colors.grey : Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamDetailScreen(exam: exam),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: sideColor!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        color: color,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exam.subjectName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 6),
                  Text(exam.formattedDate, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 12),
                  const Icon(Icons.access_time, size: 18),
                  const SizedBox(width: 6),
                  Text(exam.formattedTime, style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.meeting_room, size: 18),
                  const SizedBox(width: 6),
                  Expanded(child: Text(exam.roomsString, style: const TextStyle(fontSize: 14))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
