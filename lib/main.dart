import 'package:flutter/material.dart';
import 'package:imc_app/views/imc_view.dart';
import 'presenter/imc_presenter.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'IMC',
      home: HomePage(GeneralIMCPresenter()),
    ),
  );
}
