import 'package:flutter/material.dart';
import 'calculator.dart';
import 'number_display.dart';
import 'calculator_buttons.dart';
import 'history.dart';

class MainCalcPage extends StatefulWidget {
  const MainCalcPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainCalcPageState createState() => _MainCalcPageState();
}

class _MainCalcPageState extends State<MainCalcPage> {
  bool isNewEquation = true;
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  String calculatorString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                _navigateAndDisplayHistory(context);
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            NumberDisplay(value: calculatorString),
            CalculatorButtons(onTap: _onPressed),
          ],
        ));
  }

  _navigateAndDisplayHistory(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => History(operations: calculations)));

    if (result != null) {
      setState(() {
        isNewEquation = false;
        calculatorString = Calculator.parseString(result);
      });
    }
  }

  void _onPressed({String? buttonText}) {
    // Standard mathematical operations
    if (Calculations.theOperations.contains(buttonText)) {
      return setState(() {
        operations.add(buttonText!);
        calculatorString += " $buttonText ";
      });
    }

    // On CLEAR press
    if (buttonText == Calculations.clearCap) {
      return setState(() {
        operations.add(Calculations.clearCap);
        calculatorString = "";
      });
    }

    // On Equals press
    if (buttonText == Calculations.equalSign) {
      String newCalculatorString = Calculator.parseString(calculatorString);

      return setState(() {
        if (newCalculatorString != calculatorString) {
          // only add evaluated strings to calculations array
          calculations.add(calculatorString);
        }

        operations.add(Calculations.equalSign);
        calculatorString = newCalculatorString;
        isNewEquation = false;
      });
    }

    if (buttonText == Calculations.period) {
      return setState(() {
        calculatorString = Calculator.addPeriod(calculatorString);
      });
    }

    setState(() {
      if (!isNewEquation &&
          operations.isNotEmpty &&
          operations.last == Calculations.equalSign) {
        calculatorString = buttonText!;
        isNewEquation = true;
      } else {
        calculatorString += buttonText!;
      }
    });
  }
}
