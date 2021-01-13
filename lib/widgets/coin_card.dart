import 'package:flutter/material.dart';
import '../model/coin_model.dart';
import '../bloc/coin_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinCard extends StatefulWidget {
  const CoinCard({
    Key key,
    this.coinType,
    this.valute,
  }) : super(key: key);
  final String coinType;
  final String valute;

  @override
  State<StatefulWidget> createState() => _CoinCard();
}

class _CoinCard extends State<CoinCard> {
  CoinBloc coinBloc;

  @override
  void initState() {
    coinBloc = CoinBloc(widget.coinType, widget.valute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          side: BorderSide.merge(
              BorderSide(
                  width: 1.0,
                  color: Color(0xFFEDEEF0),
                  style: BorderStyle.solid),
              BorderSide(
                  width: 1.0,
                  color: Color(0xFFEDEEF0),
                  style: BorderStyle.solid)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: StreamBuilder<CoinState>(
              stream: coinBloc.coin,
              initialData: CoinLoadingState(),
              builder: (context, snapshot) {
                if (snapshot.data is CoinLoadingState) {
                  coinBloc.loadCoinData();
                  return loadingState();
                } else if (snapshot.data is CoinDataState) {
                  CoinDataState coinDataState = snapshot.data;
                  return dataState(coinDataState.coin);
                }
              },
            )),
      ),
    );
  }
}

Widget loadingState() {
  return SpinKitCircle(
    color: Colors.lightBlue,
    size: 20.0,
  );
}

Widget dataState(Coin coin) {
  return Text(
    '1 ${coin.coinType} = ${coin.cost} ${coin.valuteType}',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
  );
}
