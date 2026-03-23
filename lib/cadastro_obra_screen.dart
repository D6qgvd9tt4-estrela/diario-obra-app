import 'package:flutter/material.dart';

import 'db_models.dart';
import 'main.dart';

class CadastroObraScreen extends StatefulWidget {
  const CadastroObraScreen({super.key});

  @override
  State<CadastroObraScreen> createState() => _CadastroObraScreenState();
}

class _CadastroObraScreenState extends State<CadastroObraScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _contratoController = TextEditingController();
  final _toneladasController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _contratoController.dispose();
    _toneladasController.dispose();
    super.dispose();
  }

  List<double> calcularCurvaS(double totalToneladas) {
    return [
      totalToneladas * 0.10,
      totalToneladas * 0.15,
      totalToneladas * 0.25,
      totalToneladas * 0.25,
      totalToneladas * 0.15,
      totalToneladas * 0.10,
    ];
  }

  Future<void> _salvarObra() async {
    if (!_formKey.currentState!.validate()) return;

    final toneladas = double.parse(
      _toneladasController.text.replaceAll(',', '.'),
    );

    final obra = Obra()
      ..nome = _nomeController.text.trim()
      ..contrato = _contratoController.text.trim()
      ..toneladasPrevistas = toneladas
      ..dataInicio = DateTime(2026, 3, 10);

    await isar.writeTxn(() async {
      await isar.obras.put(obra);
    });

    final curva = calcularCurvaS(toneladas);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Obra salva. Mês 1: ${curva[0].toStringAsFixed(1)} t | '
          'Mês 2: ${curva[1].toStringAsFixed(1)} t',
        ),
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
          'Cadastrar Obra',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da obra / local',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome da obra.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contratoController,
                decoration: const InputDecoration(
                  labelText: 'Número do contrato',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o contrato.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _toneladasController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Total previsto de CBUQ',
                  suffixText: 't',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o total previsto.';
                  }
                  final numero = double.tryParse(value.replaceAll(',', '.'));
                  if (numero == null || numero <= 0) {
                    return 'Informe um valor válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Data base: 10/03/2026 | Prazo: 180 dias | '
                  'Produção menor no primeiro mês.',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _salvarObra,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003366),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Salvar obra'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
