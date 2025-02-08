import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Rejestracja użytkownika i wysłanie e-maila weryfikacyjnego
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Pobranie użytkownika i wysłanie e-maila weryfikacyjnego
      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
      }

      return null; // Sukces - brak błędu
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Hasło jest zbyt słabe. Wybierz silniejsze hasło.';
      } else if (e.code == 'email-already-in-use') {
        return 'Podany adres e-mail jest już zarejestrowany.';
      } else {
        return 'Wystąpił błąd: ${e.message}';
      }
    } catch (e) {
      return 'Nieoczekiwany błąd: ${e.toString()}';
    }
  }

  // 🔹 Logowanie użytkownika (bez sprawdzania weryfikacji e-maila)
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null; // Logowanie udane
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Nie znaleziono użytkownika o tym adresie e-mail.';
      } else if (e.code == 'wrong-password') {
        return 'Podano błędne hasło.';
      } else {
        return 'Błąd logowania: ${e.message}';
      }
    } catch (e) {
      return 'Nieoczekiwany błąd: ${e.toString()}';
    }
  }

  // 🔹 Wylogowanie użytkownika
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
