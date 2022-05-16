abstract class IMCView {
  void updateIMCValue(String bmiValue, String message);
  void updateWeight({String weight});
  void updateHeight({String height});
  void updateUnit(int value, String heightMessage, String weightMessage);
}
