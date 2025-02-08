import 'package:flutter/material.dart';




class ChangePasswordScreen extends StatelessWidget {
const ChangePasswordScreen({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('Zmien haslo'),
          backgroundColor: Colors.amber,
           leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), // Ikona "Wstecz"
            onPressed: () {
              Navigator.pop(context); // Powrót do poprzedniej strony
            },
           ),
      ),
      body: const FormChangePassword(
      
        
      )
    );
  }
}

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({super.key});

  @override
  State<FormChangePassword> createState()=>  _FormChangePassword();

  }

  class _FormChangePassword extends State<FormChangePassword>{
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _pass = TextEditingController();
    final TextEditingController _confrimPass = TextEditingController();

@override
Widget build(BuildContext context) {
  return Center(
    child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Marginesy boczne
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimalny rozmiar kolumny
          children: <Widget>[
            TextFormField(
              controller: _pass,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Ukrywanie tekstu dla hasła
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0), // Odstęp między elementami
            TextFormField(
              controller: _confrimPass,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Ukrywanie tekstu dla hasła
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                if(value != _pass.text){
                  return "not match";
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0), // Odstęp między polem a przyciskiem
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Dodaj tutaj logikę po zatwierdzeniu formularza
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}

  }