import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimove/screens/signin_screen.dart';

class EmailVeryficationScreen extends StatelessWidget {
  const EmailVeryficationScreen({super.key});

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
                "Wprowadź kod weryfikacyjny",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Text('Kod weryfikacyjny został wysłany na Twój adres email'),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    OtpTextField(
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      onSubmit: (String verificationCode) async {
                        try {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await user.reload();
                            if (user.emailVerified) {
                              // Kod weryfikacyjny jest poprawny
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignInScreen()),
                              );
                            } else {
                              // Kod weryfikacyjny jest niepoprawny
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Kod weryfikacyjny jest niepoprawny.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Wystąpił błąd: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await user.reload();
                          if (user.emailVerified) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Kod weryfikacyjny jest niepoprawny.'),
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
                        "Verify",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}