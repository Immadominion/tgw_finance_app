import 'package:flutter_test/flutter_test.dart';
import 'package:tgw_finance_app/tgw_calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:tgw_finance_app/tgw_calculator/maincalc.dart';
import 'test_helper.dart';

void main() {
  testWidgets('displays all the correct numbers', (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));
    List<String> buttonsToFind = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '00',
      Calculations.period,
      Calculations.clearCap,
      Calculations.equalSign,
      Calculations.addSign,
      Calculations.subtractSign,
      Calculations.multiplySign,
      Calculations.divideSign,
    ];

    for (var buttonToFind in buttonsToFind) {
      expect(find.text(buttonToFind), findsOneWidget);
    }
  });

  testWidgets('calculates the multiplication result correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '3 * 6 =';
    const String result = '18';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('calculates the addition result correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '30 + 6 =';
    const String result = '36';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('calculates the subtraction result correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '30 - 6 = ';
    const String result = '24';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('calculates the division result correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '100 / 10 =';
    const String result = '10';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('calculates the decimal result correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '10.50 + 10.25 =';
    const String result = '20.75';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('clears the current calculation correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));
    String calculationString = '20 + 10';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(calculationString), findsOneWidget);

    await tester.tap(find.text(Calculations.clearCap));
    await tester.pump();

    expect(find.text(calculationString), findsNothing);
  });

  testWidgets('multiple operations work', (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '20 + 10 =';
    String result = '30';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);

    calculationString = '30 * 10 =';
    result = '300';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);
  });

  testWidgets('shows correct history when viewing history page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainCalcPage(title: 'Calculator'));

    String calculationString = '20 + 10 =';
    String result = '30';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    expect(find.text(result), findsOneWidget);

    calculationString = '30 * 10 =';
    result = '300';
    await TestHelper.pressCalculatorButtons(calculationString, tester);

    await tester.tap(find.byIcon(Icons.history));

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(2));
  });
}
