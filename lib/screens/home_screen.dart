import 'package:flutter/material.dart';
import 'package:nutrimove/data/services/auth_service.dart'; // Importujemy AuthService

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = "Ładowanie..."; // Domyślny tekst

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // 🔹 Pobranie nazwy użytkownika
  void _loadUserName() async {
    String? name = await AuthService().getUserName();
    setState(() {
      _userName = name ?? "Nie znaleziono nazwy";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Witaj, $_userName!")),
      body: Center(child: Text("Miło Cię widzieć, $_userName!", style: TextStyle(fontSize: 20))),
    );
  }
}
