import 'dart:math';

final class Imc {
  Imc({
    required this.altura,
    required this.peso,
  });

  final double peso;
  final double altura;
  late double resultado;

  void calcularImc() {
    resultado = double.parse((peso / pow(altura, 2)).toStringAsFixed(2));
  }
}
