import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
  static Future<UserCredential> register(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  static Future<UserCredential> login(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  static Future<void> logout() async {
    await _auth.signOut();
  }
  static User? get currentUser => _auth.currentUser;
}
