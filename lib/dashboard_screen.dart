import 'package:flutter/material.dart';

import 'cadastro_obra_screen.dart';
import 'db_models.dart';
import 'lancamento_cbuq_screen.dart';
import 'main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double totalToneladas = 0;
  double mediaTemperatura = 0;
  int quantidadeLancamentos = 0;

  @override
  void initState() {
    super.initState();
    _carregarResumo();
  }

  Future<void> _carregarResumo() async {
    final agora = DateTime.now();
    final inicioDoDia = DateTime(agora.year, agora.month, agora.day);
    final fimDoDia = inicioDoDia.add(const Duration(days: 1));

    final lancamentosHoje = await isar.lancamentos
        .filter()
        .dataHoraBetween(inicioDoDia, fimDoDia)
        .findAll();

    double somaPeso = 0;
    double somaTemperatura = 0;

    for (final lancamento in lancamentosHoje) {
      somaPeso += lancamento.peso;
      somaTemperatura += lancamento.temperatura;
    }

    if (!mounted) return;

    setState(() {
      quantidadeLancamentos = lancamentosHoje.length;
      totalToneladas = somaPeso;
      mediaTemperatura =
          lancamentosHoje.isEmpty ? 0 : somaTemperatura / lancamentosHoje.length;
    });
  }

  Future<void> _abrirLancamento() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LancamentoCbuqScreen(),
      ),
    );

    if (resultado == true) {
      await _carregarResumo();
    }
  }

  Future<void> _abrirCadastroObra() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CadastroObraScreen(),
      ),
    );
  }

  Widget _buildCard(
    String titulo,
    String valor,
    Color corFundo,
    Color corTexto,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: corTexto,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            valor,
            style: TextStyle(
              color: corTexto,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUltimosLancamentosInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'Lançamentos de hoje: $quantidadeLancamentos',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diário Embraurb',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003366),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business, color: Colors.white),
            tooltip: 'Cadastrar obra',
            onPressed: _abrirCadastroObra,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _carregarResumo,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Resumo de Hoje',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    'Total de Toneladas',
                    '${totalToneladas.toStringAsFixed(1)} t',
                    const Color(0xFF003366),
                    Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCard(
                    'Média de Temp.',
                    '${mediaTemperatura.toStringAsFixed(1)} °C',
                    Colors.grey.shade200,
                    Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildUltimosLancamentosInfo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirLancamento,
        icon: const Icon(Icons.local_shipping),
        label: const Text('Lançar CBUQ'),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }
}
