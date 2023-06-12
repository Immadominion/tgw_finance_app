import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tgw_finance_app/tgw_converter/data/default_values.dart';
import 'package:tgw_finance_app/tgw_converter/util/api_calls.dart';
import 'package:tgw_finance_app/tgw_converter/widgets/appbar_widget.dart';
import 'package:tgw_finance_app/tgw_converter/widgets/buttons_grid.dart';
import 'package:tgw_finance_app/tgw_converter/widgets/currency_pickers.dart';
import 'package:tgw_finance_app/tgw_converter/widgets/value_counter.dart';

//http://api.currencyapi.com/v3/latest?apikey=MvEkyZzNoQAdIIztHVuXGZyUqqEHwigCchBv70qE

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic> currencyData;
  late RxString selectedFrom;
  late RxString selectedTo;
  late RxString ammount;
  late RxDouble selectedPrice;

  @override
  void initState() {
    selectedFrom = 'USD'.obs;
    selectedTo = 'NGN'.obs;
    ammount = '1'.obs;
    selectedPrice = 0.00.obs;
    currencyData = {};
    getRatesFromApi();
    super.initState();
  }

  Future<void> getRatesFromApi() async {
    selectedPrice.value = 0.00;
    try {
      final response =
          await ApiCalls('MvEkyZzNoQAdIIztHVuXGZyUqqEHwigCchBv70qE')
              .getRates(selectedFrom.value);
      if (response.status.hasError) {
        throw Exception('Error getting rates from API');
      }
      setState(() {
        currencyData = response.body['data'];
        selectedPrice.value = currencyData[selectedTo.value]['value'];
      });
    } catch (e) {
      SnackBar(
        content: Text('$e'),
        action: null,
        showCloseIcon: true,
      );
    }
  }

  void changeSelected(bool isFrom, String currency) {
    if (isFrom && selectedFrom.value != currency) {
      setState(() {
        selectedFrom.value = currency;
        getRatesFromApi();
      });
    } else if (!isFrom && selectedTo.value != currency) {
      setState(() {
        selectedTo.value = currency;
        selectedPrice.value = currencyData[selectedTo.value]['value'];
      });
    }
  }

  void switchCurrencies() {
    setState(() {
      final selectedFromTemp = selectedFrom.value;
      selectedFrom.value = selectedTo.value;
      selectedTo.value = selectedFromTemp;
      getRatesFromApi();
    });
  }

  void backspace() {
    if (ammount.value.isNotEmpty) {
      setState(() {
        ammount.value = ammount.value.substring(0, ammount.value.length - 1);
      });
    }
  }

  void changeAmmount(String value) {
    final index = ammount.value.indexOf(',');
    if (value == '0' && ammount.value == '0') {
    } else if (ammount.value == '0' && value != ',') {
      setState(() {
        ammount.value = value;
      });
    } else if (ammount.value.isEmpty && value == ',') {
      setState(() {
        ammount.value = '0,';
      });
    } else if (!ammount.value.contains(',') &&
        value == ',' &&
        ammount.value.isNotEmpty) {
      setState(() {
        ammount.value = '${ammount.value}$value';
      });
    } else if (value != '' &&
        ammount.value.contains(',') &&
        ammount.value.length - index < 3) {
      setState(() {
        ammount.value = '${ammount.value}$value';
      });
    } else if (value != ',' && !ammount.value.contains(',')) {
      setState(() {
        ammount.value = '${ammount.value}$value';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: appbarWidget(themeData),
      body: SafeArea(
        child: Padding(
          padding: paddingV1,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              currencyPickers(selectedFrom, selectedTo, switchCurrencies,
                  changeSelected, themeData),
              valueCounter(
                  ammount, selectedFrom, selectedTo, selectedPrice, themeData),
              buttonsGrid(changeAmmount, backspace, themeData),
            ],
          ),
        ),
      ),
    );
  }
}
