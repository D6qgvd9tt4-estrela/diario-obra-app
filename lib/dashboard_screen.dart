import 'package:flutter/material.dart';
import 'cadastro_obra_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário de Obras', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business, color: Colors.white),
            tooltip: 'Cadastrar Obra',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CadastroObraScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo de Hoje',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCard('Total de Toneladas', '0 t', Colors.blue.shade900, Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCard('Média de Temp.', '0 °C', Colors.grey.shade200, Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Lançar CBUQ'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCard(String titulo, String valor, Color corFundo, Color corTexto) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: TextStyle(color: corTexto, fontSize: 14)),
          const SizedBox(height: 8),
          Text(valor, style: TextStyle(color: corTexto, fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
