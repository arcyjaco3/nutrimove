import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimove/screens/step_by_step.dart';

class EmailVeryficationScreen extends StatelessWidget {
  const EmailVeryficationScreen({super.key});

  Future<void> _resendVerificationEmail(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail weryfikacyjny został wysłany ponownie.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wystąpił błąd: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Icon(Icons.email_outlined, size: 100, color: Colors.blue),
              SizedBox(height: 50),
              Text(
                "Sprawdź swoją skrzynkę pocztową",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Text('E-mail weryfikacyjny został wysłany na Twój adres email'),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await user.reload();
                    if (user.emailVerified) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StepByStepScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('E-mail nie został jeszcze zweryfikowany.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC107),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Sprawdź weryfikację",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _resendVerificationEmail(context),
                child: Text(
                  "Nie otrzymałeś e-maila? Wyślij ponownie",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}