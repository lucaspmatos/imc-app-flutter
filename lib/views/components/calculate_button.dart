import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({Key? key, this.calculator}) : super(key: key);

  final void Function()? calculator;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: calculator,
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent,
        textStyle: const TextStyle(
          color: Colors.white70,
        ),
      ),
      child: const Text(
        'Calculate',
        style: TextStyle(fontSize: 16.9),
      ),
    );
  }
}
