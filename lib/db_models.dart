import 'package:isar/isar.dart';

part 'db_models.g.dart';

@collection
class Obra {
  // FIX: Usando autoIncrement para garantir compatibilidade com a Web
  Id id = Isar.autoIncrement; 
  
  late String nome;
  late String contrato;
  late double toneladasPrevistas;
  late DateTime dataInicio;
}

@collection
class Lancamento {
  // FIX: Usando autoIncrement para garantir compatibilidade com a Web
  Id id = Isar.autoIncrement;
  
  late String placa;
  late double peso;
  late double temperatura;
  late DateTime dataHora;
  
  double? latitude;
  double? longitude;
}
