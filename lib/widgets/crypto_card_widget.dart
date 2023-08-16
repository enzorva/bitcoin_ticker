import 'package:flutter/material.dart';

class CryptoCardWidget extends StatelessWidget {
  const CryptoCardWidget(
      {super.key,
      required this.cryptoName,
      required this.roundedPrice,
      required this.selectedCurrency});

  final String cryptoName;
  final String roundedPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoName = $roundedPrice $selectedCurrency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
