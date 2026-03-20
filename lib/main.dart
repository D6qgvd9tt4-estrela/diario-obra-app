import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const MeuAppDiario());
}

class MeuAppDiario extends StatelessWidget {
  const MeuAppDiario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário Embraurb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
