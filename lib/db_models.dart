import 'package:isar/isar.dart';

part 'db_models.g.dart';

@collection
class Obra {
  Id id = Isar.autoIncrement;
  late String nome;
  late String contrato;
  late double toneladasPrevistas;
  late DateTime dataInicio;
}

@collection
class Lancamento {
  Id id = Isar.autoIncrement;
  late String placa;
  late double peso;
  late double temperatura;
  late DateTime dataHora;
  
  // Preparado para capturar a coordenada GPS no futuro
  double? latitude;
  double? longitude;
}
