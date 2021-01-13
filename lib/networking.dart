import 'package:http/http.dart' as http;
import 'responses/coin_response.dart';
import 'dart:convert';

const URL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
const publicKey = 'NWVlY2E5M2MyYWNhNDQ2NGE4ZjNmNzYwODQyZjE3M2Y';

class Networking {
  Future<CoinResponse> getCoinData(String coinType, String valute) async {
    print('$URL$coinType$valute');
    http.Response response = await http
        .get('$URL$coinType$valute', headers: {'x-ba-key': publicKey});
    if (response.statusCode == 200) {
      dynamic data = response.body;
      if (data != null && data != '') {
        return CoinResponse.fromJson(coinType, valute, jsonDecode(data));
      } else {
        return CoinResponse.withError('Ошибка при получении данных');
      }
    } else {
      print(response.statusCode);
      return CoinResponse.withError('Ошибка при получении данных');
    }
  }
}
