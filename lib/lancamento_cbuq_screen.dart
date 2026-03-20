import 'package:flutter/material.dart';

class LancamentoCbuqScreen extends StatefulWidget {
  const LancamentoCbuqScreen({super.key});

  @override
  State<LancamentoCbuqScreen> createState() => _LancamentoCbuqScreenState();
}

class _LancamentoCbuqScreenState extends State<LancamentoCbuqScreen> {
  final _placaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _tempController = TextEditingController();

  void _salvarLancamento() {
    if (_placaController.text.isEmpty || _pesoController.text.isEmpty) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CBUQ Lançado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // Volta para a tela inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lançar CBUQ', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dados do Caminhão', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _placaController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Placa do Caminhão', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Peso (Toneladas)', border: OutlineInputBorder(), suffixText: 't'),
            ),
            const SizedBox(height: 16),
            TextField
