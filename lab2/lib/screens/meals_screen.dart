import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_summary.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  const MealsScreen({super.key});
  @override
  State<MealsScreen> createState() => _MealsScreenState();
}
class _MealsScreenState extends State<MealsScreen> {
  List<MealSummary> _meals = [];
  List<MealSummary> _filtered = [];
  bool _loading = true;
  final _searchCtrl = TextEditingController();
  late String category;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    category = ModalRoute.of(context)!.settings.arguments as String;
    _loadMeals();
    _searchCtrl.addListener(_onSearch);
  }
  void _onSearch() async {
    final q = _searchCtrl.text.trim();
    if (q.isEmpty) {
      setState(() => _filtered = _meals);
      return;
    }
    final results = await ApiService.searchMeals(q);
    final byCategory = results.where((m) => _meals.any((mm) => mm.id == m.id)).toList();
    setState(() => _filtered = byCategory);
  }
  Future<void> _loadMeals() async {
    try {
      final list = await ApiService.fetchMealsByCategory(category);
      setState(() {
        _meals = list;
        _filtered = list;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading meals: $e')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search meals in this category...'),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _filtered.length,
              itemBuilder: (context, i) {
                final m = _filtered[i];
                return MealCard(
                  meal: m,
                  onTap: () async {
                    final detail = await ApiService.lookupMeal(m.id);
                    if (detail != null) {
                      Navigator.pushNamed(context, MealDetailScreen.routeName, arguments: detail);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load meal details.')));
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
