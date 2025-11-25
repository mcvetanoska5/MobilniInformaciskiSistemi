import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';
  const MealDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final MealDetail meal = ModalRoute.of(context)!.settings.arguments as MealDetail;
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (meal.thumbnail.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(meal.thumbnail, height: 220, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(meal.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Category: ${meal.category}  •  Area: ${meal.area}'),
            const SizedBox(height: 12),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...meal.ingredients.entries.map((e) => Text('${e.key} — ${e.value}')),
            const SizedBox(height: 12),
            const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(meal.instructions),
            const SizedBox(height: 12),
            if (meal.youtube.isNotEmpty) ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(meal.youtube);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              icon: const Icon(Icons.video_label),
              label: const Text('Watch on YouTube'),
            ),
          ],
        ),
      ),
    );
  }
}
