import 'number_formatter.dart';

class Calculations {
  static const period = '.';
  static const multiplySign = '*';
  static const subtractSign = '-';
  static const addSign = '+';
  static const divideSign = '/';
  static const clearCap = 'CLEAR';
  static const equalSign = '=';
  static const theOperations = [
    Calculations.addSign,
    Calculations.multiplySign,
    Calculations.subtractSign,
    Calculations.divideSign,
  ];

  static double add(double a, double b) => a + b;
  static double subtract(double a, double b) => a - b;
  static double divide(double a, double b) => a / b;
  static double multiply(double a, double b) => a * b;
}

class Calculator {
  static String parseString(String text) {
    List<String> numbersToAdd;
    double a, b, result;
    if (text.contains(Calculations.addSign)) {
      numbersToAdd = text.split(Calculations.addSign);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.add(a, b);
    } else if (text.contains(Calculations.multiplySign)) {
      numbersToAdd = text.split(Calculations.multiplySign);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.multiply(a, b);
    } else if (text.contains(Calculations.divideSign)) {
      numbersToAdd = text.split(Calculations.divideSign);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.divide(a, b);
    } else if (text.contains(Calculations.subtractSign)) {
      numbersToAdd = text.split(Calculations.subtractSign);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.subtract(a, b);
    } else {
      return text;
    }

    return NumberFormatter.format(result.toString());
  }

  static String addPeriod(String calculatorString) {
    if (calculatorString.isEmpty) {
      return calculatorString = '0${Calculations.period}';
    }

    RegExp exp = RegExp(r"\d\.");
    Iterable<Match> matches = exp.allMatches(calculatorString);
    int maxMatches = Calculator.includesOperation(calculatorString) ? 2 : 1;

    return matches.length == maxMatches
        ? calculatorString
        : calculatorString += Calculations.period;
  }

  static bool includesOperation(String calculatorString) {
    for (var operation in Calculations.theOperations) {
      if (calculatorString.contains(operation)) {
        return true;
      }
    }

    return false;
  }
}
