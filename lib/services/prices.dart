import 'package:bitcoin_ticker/services/networking.dart';

//const apiKey = 'FB8931D1-399A-4824-BCCC-58AAD0E6DF09';
const coinDataURL = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD';

class PriceModel {
  Future<dynamic> getBtcPrice(String currency) async {
    NetworkHelper networkHelper = NetworkHelper(coinDataURL);

    var priceData = await networkHelper.getData();
    return priceData;
  }
}
