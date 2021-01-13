import 'dart:async';
import 'package:bitcoin_ticker/networking.dart';
import 'package:bitcoin_ticker/model/coin_model.dart';

class CoinBloc {
  CoinBloc(this.coinType, this.valute);
  final String coinType;
  final String valute;

  final networking = Networking();

  final _streamController = StreamController<CoinState>();

  Stream<CoinState> get coin => _streamController.stream;

  void loadCoinData() {
    _streamController.sink.add(CoinState._coinLoading());
    networking.getCoinData(coinType, valute).then((coin) {
      _streamController.sink.add(CoinState._coinData(coin.coin));
    });
  }

  void dispose() {
    _streamController.close();
  }
}

class CoinState {
  CoinState();
  factory CoinState._coinLoading() = CoinLoadingState;
  factory CoinState._coinData(Coin coin) = CoinDataState;
}

class CoinLoadingState extends CoinState {}

class CoinDataState extends CoinState {
  CoinDataState(this.coin);
  final Coin coin;
}
