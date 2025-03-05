import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrimove/data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Pobierz aktualnie zalogowanego użytkownika
  User? get currentUser => _auth.currentUser;

  // 🔹 Rejestracja użytkownika + weryfikacja e-maila
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔥 Rejestracja użytkownika: email=$email');

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        await saveUserData(user.uid, email, password);
        debugPrint('✅ Użytkownik zarejestrowany: ${user.uid}');
      }

      return null; // Sukces
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Błąd rejestracji: ${e.code} - ${e.message}');
      if (e.code == 'email-already-in-use') {
        return 'Podany adres e-mail jest już zarejestrowany.';
      } else if (e.code == 'weak-password') {
        return 'Hasło jest zbyt słabe. Wybierz silniejsze.';
      } else {
        return 'Błąd rejestracji: ${e.message}';
      }
    }
  }

  // 🔹 Zapisz dane użytkownika w Firestore
  Future<void> saveUserData(String uid, String email, String password) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
      });
      debugPrint('✅ Dane użytkownika zapisane');
    } catch (e) {
      debugPrint('❌ Błąd zapisu danych: ${e.toString()}');
    }
  }

  // 🔹 Zapisz dodatkowe dane użytkownika w Firestore
  Future<void> saveAdditionalUserData(UserModel userModel) async {
    try {
      await _firestore.collection('users').doc(userModel.id).set(userModel.toJson(), SetOptions(merge: true));
      debugPrint('✅ Dodatkowe dane użytkownika zapisane');
    } catch (e) {
      debugPrint('❌ Błąd zapisu dodatkowych danych: ${e.toString()}');
    }
  }

  // 🔹 Logowanie użytkownika (sprawdza weryfikację e-maila)
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔹 Próba logowania: email=$email');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        return 'Zweryfikuj swój adres e-mail przed logowaniem!';
      }

      debugPrint('✅ Logowanie udane!');
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Błąd logowania: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        return 'Nie znaleziono użytkownika o tym adresie e-mail.';
      } else if (e.code == 'wrong-password') {
        return 'Podano błędne hasło.';
      } else {
        return 'Błąd logowania: ${e.message}';
      }
    }
  }

  // 🔹 Resetowanie hasła
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return 'Wysłano e-mail do zresetowania hasła.';
    } on FirebaseAuthException catch (e) {
      return 'Błąd resetowania hasła: ${e.message}';
    }
  }

  // 🔹 Wylogowanie użytkownika
  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint('✅ Użytkownik wylogowany');
  }

  // 🔹 TEST
   Future<String?> getUserName() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists && userDoc.data() != null) {
          return userDoc['name']; // Pobieramy nazwę użytkownika
        }
      }
      return null;
    } catch (e) {
      debugPrint("❌ Błąd pobierania użytkownika: $e");
      return null;
    }
  }
}