import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StepByStepScreen extends StatefulWidget {
  const StepByStepScreen({super.key});

  @override
  _StepByStepScreenState createState() => _StepByStepScreenState();
}

class _StepByStepScreenState extends State<StepByStepScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  final TextEditingController _nameController = TextEditingController();
  int _age = 18;
  String _gender = "Mężczyzna";
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _saveUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text.trim(),
        'age': _age,
        'gender': _gender,
        'height': int.tryParse(_heightController.text.trim()) ?? 0,
        'weight': int.tryParse(_weightController.text.trim()) ?? 0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dane zapisane pomyślnie!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _currentStep--;
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
              )
            : null,
        actions: [
          Row(
            children: [
              Text(
                _currentStep < _totalSteps - 1 ? "Next" : "Finish",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(
                  _currentStep < _totalSteps - 1 ? Icons.arrow_forward : Icons.check),
                onPressed: () {
                  if (_currentStep < _totalSteps - 1) {
                    setState(() {
                      _currentStep++;
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  } else {
                    _saveUserData();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStep("Wpisz swoje imię", TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Imię'))),
                  _buildStep("Wybierz swój wiek", DropdownButton<int>(
                    value: _age,
                    items: List.generate(100, (index) => index + 1)
                        .map((age) => DropdownMenuItem(value: age, child: Text('$age')))
                        .toList(),
                    onChanged: (value) => setState(() => _age = value ?? 18),
                  )),
                  _buildStep("Wybierz płeć", Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _genderButton("Mężczyzna"),
                      SizedBox(width: 16),
                      _genderButton("Kobieta"),
                      SizedBox(width: 16),
                      _genderButton("Wolę nie mówić"),
                    ],
                  )),
                  _buildStep("Podaj wzrost i wagę", Column(
                    children: [
                      TextField(controller: _heightController, decoration: InputDecoration(labelText: 'Wzrost (cm)')),
                      SizedBox(height: 16),
                      TextField(controller: _weightController, decoration: InputDecoration(labelText: 'Waga (kg)')),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _genderButton(String gender) {
    return ElevatedButton(
      onPressed: () => setState(() => _gender = gender),
      child: Text(gender),
      style: ElevatedButton.styleFrom(
        backgroundColor: _gender == gender ? Colors.blue : Colors.grey[300],
        foregroundColor: _gender == gender ? Colors.white : Colors.black,
      ),
    );
  }
}
