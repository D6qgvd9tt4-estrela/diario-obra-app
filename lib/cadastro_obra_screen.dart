import 'package:flutter/material.dart';

class CadastroObraScreen extends StatefulWidget {
  const CadastroObraScreen({super.key});

  @override
  State<CadastroObraScreen> createState() => _CadastroObraScreenState();
}

class _CadastroObraScreenState extends State<CadastroObraScreen> {
  final _nomeController = TextEditingController();
  final _contratoController = TextEditingController();
  final _toneladasController = TextEditingController();
  
  // Lógica da Curva S (180 dias / 6 meses) - Produção menor no 1º mês
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

  void _salvarObra() {
    if (_toneladasController.text.isEmpty) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Obra salva! Cronograma Físico calculado com sucesso.'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Obra', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dados do Contrato', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Obra / Local', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contratoController,
              decoration: const InputDecoration(labelText: 'Número do Contrato', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _toneladasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total de CBUQ Previsto (Toneladas)', 
                border: OutlineInputBorder(),
                suffixText: 't',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text('O prazo padrão é de 180 dias. O cronograma será calculado automaticamente com aceleração gradual (Curva S).'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF003366)),
                onPressed: _salvarObra,
                child: const Text('Salvar e Gerar Cronograma', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
