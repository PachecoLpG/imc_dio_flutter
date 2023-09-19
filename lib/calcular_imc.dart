import 'dart:math';

double calcularImc(double peso, double altura) {
  return double.parse((peso / pow(altura, 2)).toStringAsFixed(2));
}
