import '../utils/interfaces.dart';
import '../utils/utils.dart';

import '../view_model/imc_view_model.dart';

abstract class IMCPresenter {
  void onCalculateClicked(String weightString, String heightString);
  void onOptionChanged(int value, String weightString, String heightString);
  set imcView(IMCView value);

  void onAgeSubmitted(String age);
  void onHeightSubmitted(String height);
  void onWeightSubmitted(String weight);
}

class GeneralIMCPresenter implements IMCPresenter {
  late IMCViewModel _viewModel;
  late IMCView _view;

  GeneralIMCPresenter() {
    _viewModel = IMCViewModel();
  }

  @override
  void onCalculateClicked(String weightString, String heightString) {
    var height = 0.0;
    var weight = 0.0;
    try {
      height = double.parse(heightString);
    } catch (e) {}
    try {
      weight = double.parse(weightString);
    } catch (e) {}
    _viewModel.height = height;
    _viewModel.weight = weight;
    _viewModel.imc = calculator(height, weight);
    _view.updateIMCValue(_viewModel.imcInString, _viewModel.imcMessage);
  }

  @override
  void onOptionChanged(int value, String weightString, String heightString) {
    const weightScale = 2.2046226218;
    const heightScale = 2.54;

    late double height;
    late double weight;

    if (!isEmptyString(heightString)) {
      try {
        height = double.parse(heightString);
      } catch (e) {}
    }
    if (!isEmptyString(weightString)) {
      try {
        weight = double.parse(weightString);
      } catch (e) {}
    }

    _viewModel.weight = weight / weightScale;
    _viewModel.height = height * heightScale;

    _view.updateHeight(height: _viewModel.heightInString);
    _view.updateWeight(weight: _viewModel.weightInString);
  }

  @override
  void onAgeSubmitted(String age) {
    // TODO: will implement late
  }

  @override
  void onHeightSubmitted(String height) {
    try {
      _viewModel.height = double.parse(height);
    } catch (e) {}
  }

  @override
  void onWeightSubmitted(String weight) {
    try {
      _viewModel.weight = double.parse(weight);
    } catch (e) {}
  }

  @override
  set imcView(IMCView value) {
    // TODO: implement imcView
  }
}
