import 'package:flutter/material.dart';

typedef CalculatorButtonTapCallback = void Function({String buttonText});

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({super.key, this.text = '', required this.onTap});

  final String text;
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          width: 0.5,
        ),
      ),
      child: TextButton(
        onPressed: () => onTap(buttonText: text),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(30),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 217, 227, 231),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    ));
  }
}
