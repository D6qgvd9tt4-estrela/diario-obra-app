import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dashboard_screen.dart';
import 'db_models.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [ObraSchema, LancamentoSchema],
    directory: dir.path,
  );
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003366)),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
