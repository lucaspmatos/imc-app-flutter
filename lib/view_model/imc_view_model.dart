import '../utils/utils.dart';

class IMCViewModel {
  double imc = 0.0;

  double? height;
  double? weight;

  String get imcMessage => determineIMC(imc);
  String get imcInString => imc.toStringAsFixed(2);
  String get heightInString => height != null ? height.toString() : '';
  String get weightInString => weight != null ? weight.toString() : '';

  IMCViewModel();
}
