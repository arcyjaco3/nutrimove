import 'package:flutter/material.dart';
import 'package:nutrimove/screens/signin_screen.dart'; // Import widoku
import 'package:nutrimove/screens/signup_screen.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFED683), // Kolor tła (#FED683)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tytuł
            Text(
              "Welcome to NutriFit",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 80),
            // Miejsce na obrazek awokado
            Container(
              width: 200, // Szerokość kontenera
              height: 200, // Wysokość kontenera
              color: Color(0xFFFED683), // Kolor tła (#FED683)
              child: Image.asset(
                'assets/images/avocado_chef.png', // Ścieżka do obrazu
                fit: BoxFit.contain, // Dopasowanie obrazu
              ),
            ),
            SizedBox(height: 150),
            // Przycisk Rejestracji
            ElevatedButton(
              onPressed: () {
                // Akcja przycisku logowania
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignInScreen())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC107), // Żółty kolor przycisku
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            // Link logowania
        ElevatedButton(
              onPressed: () {
                // Akcja przycisku rejestracji
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const SignUpScreen())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC107), // Żółty kolor przycisku
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
