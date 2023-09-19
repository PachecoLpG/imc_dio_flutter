import 'package:hive/hive.dart';

part 'imc.g.dart';

@HiveType(typeId: 0)
class Imc extends HiveObject {
  Imc({
    required this.altura,
    required this.peso,
    this.resultado,
  });

  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  @HiveField(2)
  double? resultado;
}
