import 'package:bitcoin_ticker/model/coin_model.dart';

class CoinResponse {
  CoinResponse(this.error) {
    coin = Coin(coinType: 'Some coin', cost: 0.0, valuteType: 'Some valute');
  }
  Coin coin;
  final String error;

  CoinResponse.fromJson(String coinT, String valute, Map<String, dynamic> json)
      : this.coin =
            Coin(coinType: coinT, valuteType: valute, cost: json['last']),
        error = '';

  CoinResponse.withError(String error)
      : this.coin =
            Coin(coinType: 'Some coin', cost: 0.0, valuteType: 'Some valute'),
        this.error = error;
}
