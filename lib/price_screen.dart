import 'package:bitcoin_ticker/services/prices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'package:bitcoin_ticker/widgets/crypto_card_widget.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final getdata = PriceModel();
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  String selectedCurrency = 'USD';
  double price = 0.0;
  String roundedBtcPrice = "?";
  String roundedEthPrice = "?";
  String roundedLtcPrice = "?";

  @override
  void initState() {
    super.initState();
    //init();
  }

  Future<String> safePrice(String selectedCurrency, String cryptoName) async {
    final ltcMap = await getdata.getCryptoPrice(selectedCurrency, cryptoName);
    double ltcPrice = ltcMap['rate'];
    String roundedLtcPrice = numberFormat.format(ltcPrice);
    return roundedLtcPrice;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        selectedCurrency = value ?? "USD";

        roundedBtcPrice = await safePrice(selectedCurrency, 'BTC');

        roundedEthPrice = await safePrice(selectedCurrency, 'ETH');

        roundedLtcPrice = await safePrice(selectedCurrency, 'LTC');

        setState(() {});
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
    throw UnsupportedError("Unsupported platform");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CryptoCardWidget(
                    cryptoName: 'BTC',
                    roundedPrice: roundedBtcPrice,
                    selectedCurrency: selectedCurrency),
                CryptoCardWidget(
                    cryptoName: 'ETH',
                    roundedPrice: roundedEthPrice,
                    selectedCurrency: selectedCurrency),
                CryptoCardWidget(
                    cryptoName: 'LTC',
                    roundedPrice: roundedLtcPrice,
                    selectedCurrency: selectedCurrency),
              ],
            ),
          ),

          // ElevatedButton(
          //     onPressed: () => getdata.getBtcPrice(selectedCurrency),
          //     child: const Text('test')),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()),
        ],
      ),
    );
  }
}
