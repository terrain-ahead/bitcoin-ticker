import 'package:bitcoin_ticker/bloc/coin_bloc.dart';
import 'model/coin_model.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'widgets/coin_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  _PriceScreenState();
  String selectedCurrentVal = 'USD';
  String selectedCurrentCrypto = 'BTC';
  List<CoinCard> coinCardList = [];
  Map<String, double> costDict = {};

  DropdownButton<String> getAndroidDropDown(String type) {
    List<String> list = type == 'val' ? currenciesList : cryptoList;
    List<DropdownMenuItem<String>> listOfSmth = [];
    for (String str in list) {
      var myItem = DropdownMenuItem(
        child: Text(str),
        value: str,
      );
      listOfSmth.add(myItem);
    }
    return DropdownButton<String>(
      value: type == 'val' ? selectedCurrentVal : selectedCurrentCrypto,
      items: listOfSmth,
      onChanged: (value) {
        if (type == 'val') {}
        setState(() {
          if (type == 'val') {
            selectedCurrentVal = value;
          } else if (type == 'crypto') {
            selectedCurrentCrypto = value;
          }
        });
      },
    );
  }

  CupertinoPicker getIosPicker() {
    List<Text> list = [];
    for (String str in currenciesList) {
      var myItem = new Text(
        str,
        style: TextStyle(
          color: Colors.white,
          fontSize: 19.0,
        ),
      );
      list.add(myItem);
    }
    return CupertinoPicker(
        itemExtent: 28.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrentVal = currenciesList[selectedIndex];
          });
        },
        children: list);
  }

  void addCoinCard() {
    for (var i in coinCardList) {
      if (i.coinType == selectedCurrentCrypto &&
          i.valute == selectedCurrentVal) {
        return;
      }
    }
    setState(() {
      coinCardList.add(CoinCard(
        coinType: selectedCurrentCrypto,
        valute: selectedCurrentVal,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    coinCardList.add(CoinCard(coinType: 'BTC', valute: 'USD'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(children: coinCardList),
          /*GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            childAspectRatio: 5.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 1,
            children: coinCardList,
          ),*/
          /*GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: coinCardList[index],
                );
              }),*/
          Container(
              height: 140.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 10.0),
              color: Colors.lightBlue,
              child: Row(children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Platform.isIOS
                            ? getIosPicker()
                            : getAndroidDropDown('val')),
                    Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Platform.isIOS
                            ? getIosPicker()
                            : getAndroidDropDown('crypto')),
                  ],
                ),
                SizedBox(
                  width: 30.0,
                ),
                RowIconButton(
                  icon: FontAwesomeIcons.plusCircle,
                  onpressed: () {
                    addCoinCard();
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
                TextButton(
                    txt: Text(
                      'clear',
                      style: kLitleTextStyle,
                    ),
                    onpressed: () {
                      setState(() {
                        coinCardList.clear();
                      });
                    })
              ]))
        ],
      ),
    );
  }
}

class RowIconButton extends StatelessWidget {
  RowIconButton({@required this.icon, @required this.onpressed});

  final IconData icon;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onpressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF1186BB),
    );
  }
}

class TextButton extends StatelessWidget {
  TextButton({@required this.txt, @required this.onpressed});

  final Text txt;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: txt,
      onPressed: onpressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF1186BB),
    );
  }
}
