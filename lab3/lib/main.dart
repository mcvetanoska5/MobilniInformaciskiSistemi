import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Иницијализација на Firebase со конфигурација за сите платформи
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealDB Recipes',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: StreamBuilder<User?>(
        stream: AuthService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const CategoriesScreen();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        MealsScreen.routeName: (context) => const MealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FavoritesScreen.routeName: (context) => FavoritesScreen(),
      },
    );
  }
}
