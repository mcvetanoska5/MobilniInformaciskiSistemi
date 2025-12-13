import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal_summary.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String base = 'https://www.themealdb.com/api/json/v1/1';
  static Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$base/categories.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = data['categories'] as List<dynamic>;
      return list.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
  static Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$base/filter.php?c=${Uri.encodeComponent(category)}');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = data['meals'] as List<dynamic>?;
      if (list == null) return [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals for category $category');
    }
  }
  static Future<List<MealSummary>> searchMeals(String query) async {
    final url = Uri.parse('$base/search.php?s=${Uri.encodeComponent(query)}');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = data['meals'] as List<dynamic>?;
      if (list == null) return [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }
  static Future<MealDetail?> lookupMeal(String id) async {
    final url = Uri.parse('$base/lookup.php?i=${Uri.encodeComponent(id)}');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = data['meals'] as List<dynamic>?;
      if (list == null || list.isEmpty) return null;
      return MealDetail.fromJson(list.first as Map<String, dynamic>);
    } else {
      throw Exception('Failed to lookup meal $id');
    }
  }
  static Future<MealDetail?> randomMeal() async {
    final url = Uri.parse('$base/random.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = data['meals'] as List<dynamic>?;
      if (list == null || list.isEmpty) return null;
      return MealDetail.fromJson(list.first as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch random meal');
    }
  }
}
