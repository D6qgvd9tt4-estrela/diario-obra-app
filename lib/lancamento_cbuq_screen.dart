import 'package:flutter/material.dart';

import 'db_models.dart';
import 'main.dart';

class LancamentoCbuqScreen extends StatefulWidget {
  const LancamentoCbuqScreen({super.key});

  @override
  State<LancamentoCbuqScreen> createState() => _LancamentoCbuqScreenState();
}

class _LancamentoCbuqScreenState extends State<LancamentoCbuqScreen> {
  final _formKey = GlobalKey<FormState>();

  final _placaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _tempController = TextEditingController();

  @override
  void dispose() {
    _placaController.dispose();
    _pesoController.dispose();
    _tempController.dispose();
    super.dispose();
  }

  Future<void> _salvarLancamento() async {
    if (!_formKey.currentState!.validate()) return;

    final novoLancamento = Lancamento()
      ..placa = _placaController.text.trim().toUpperCase()
      ..peso = double.parse(_pesoController.text.replaceAll(',', '.'))
      ..temperatura = double.parse(_tempController.text.replaceAll(',', '.'))
      ..dataHora = DateTime.now();

    await isar.writeTxn(() async {
      await isar.lancamentos.put(novoLancamento);
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lançamento salvo com sucesso.'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lançar CBUQ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _placaController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Placa do caminhão',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a placa.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pesoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso (toneladas)',
                  suffixText: 't',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o peso.';
                  }
                  final numero = double.tryParse(value.replaceAll(',', '.'));
                  if (numero == null || numero <= 0) {
                    return 'Informe um peso válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tempController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Temperatura',
                  suffixText: '°C',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a temperatura.';
                  }
                  final numero = double.tryParse(value.replaceAll(',', '.'));
                  if (numero == null) {
                    return 'Informe uma temperatura válida.';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _salvarLancamento,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Salvar lançamento'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
