import 'package:bitcoin_ticker/services/networking.dart';

var cryptoName = 'BTC';

class PriceModel {
  Future<dynamic> getCryptoPrice(String currency, String cryptoName) async {
    final coinDataURL =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoName/$currency';
    NetworkHelper networkHelper = NetworkHelper(coinDataURL);

    var priceData = await networkHelper.getData();
    return priceData;
  }
}
