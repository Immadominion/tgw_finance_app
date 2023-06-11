import 'package:flutter/material.dart';
import 'calculator.dart';
import 'calculator_button.dart';
import 'calculator_row.dart';

class CalculatorButtons extends StatelessWidget {
  CalculatorButtons({super.key, required this.onTap});

  final CalculatorButtonTapCallback onTap;
  final calculatorButtonRows = [
    ['7', '8', '9', Calculations.divideSign],
    ['4', '5', '6', Calculations.multiplySign],
    ['1', '2', '3', Calculations.subtractSign],
    [Calculations.period, '0', '00', Calculations.addSign],
    [Calculations.clearCap, Calculations.equalSign]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: calculatorButtonRows.map((calculatorRowButtons) {
      return CalculatorRow(
        buttons: calculatorRowButtons,
        onTap: onTap,
      );
    }).toList());
  }
}
