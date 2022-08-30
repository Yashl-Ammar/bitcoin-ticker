import 'package:bitcoin_ticker/Networking.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  Networking networking = Networking();

  String btcRate = '?';

  Future<void> getBTCRate(String value) async{

    String completeUrl = '$defaulturl/BTC/$value?apikey=$apiKey';

    var decodeddata = await networking.getRate(completeUrl);
    if(decodeddata == null){
      btcRate = '?';
      return;
    }

    double btc = decodeddata['rate'];
    btcRate = btc.toStringAsFixed(0);
  }

  String ethRate = '?';

  Future<void> getethRate(String value) async{

    String completeUrl = '$defaulturl/ETH/$value?apikey=$apiKey';

    var decodeddata = await networking.getRate(completeUrl);
    if(decodeddata == null){
      ethRate = '?';
      return;
    }
    double eth = decodeddata['rate'];
    ethRate = eth.toStringAsFixed(0);
  }

  String ltcRate = '?';

  Future<void> getltcRate(String value) async{

    String completeUrl = '$defaulturl/LTC/$value?apikey=$apiKey';

    var decodeddata = await networking.getRate(completeUrl);
    if(decodeddata == null){
      ltcRate = '?';
      return;
    }
    double ltc = decodeddata['rate'];
    ltcRate = ltc.toStringAsFixed(0);
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      DropdownMenuItem<String> temp = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );

      dropDownMenuItems.add(temp);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenuItems,
      onChanged: (value) async {
        await getBTCRate(value!);
        await getethRate(value);
        await getltcRate(value);
        setState(()  {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> temp = [];
    for (int i = 0; i < currenciesList.length; i++) {
      temp.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (onSelectedItemChanged) async{
        String value = currenciesList[onSelectedItemChanged];
        await getBTCRate(value);
        await getethRate(value);
        await getltcRate(value);
        setState(() {
          selectedCurrency = value;
        });
      },
      children: temp,
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container(),),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}
