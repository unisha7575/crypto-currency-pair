import 'package:crypto_demo_project/models/order_book_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/crypto_models.dart';

class CryptoController extends GetxController {
  OrderBookModel? _orderData;
  String _suggestionSelectedPair = '';
  final List<String> _currencyPair = <String>[
    "btcusd",
    "btceur",
    "btcgbp",
    "btcpax",
    "btcusdc",
    "gbpusd",
    "gbpeur",
    "eurusd",
    "xrpusd",
    "xrpeur",
    "xrpbtc",
    "xrpgbp",
    "xrppax",
    "ltcusd",
    "ltceur",
    "ltcbtc",
    "ltcgbp",
    "ethusd",
    "etheur",
    "ethbtc",
    "ethgbp",
    "ethpax",
    "ethusdc",
    "bchusd",
    "bcheur",
    "bchbtc",
    "bchgbp",
    "paxusd",
    "paxeur",
    "paxgbp",
    "xlmbtc",
    "xlmusd",
    "xlmeur",
    "xlmgbp",
    "linkusd",
    "linkeur",
    "linkgbp",
    "linkbtc",
    "linketh",
    "omgusd",
    "omgeur",
    "omggbp",
    "omgbtc",
    "usdcusd"
  ];

  List<String> get getCurrencyPair => _currencyPair;

  String get getSuggestionSelectedPair => _suggestionSelectedPair;

  OrderBookModel? get getOrderData => _orderData;
  bool isClicked = true;

  CryptoModel? _cryptoData;

  // TextEditingController currencyPairTextEditingController = TextEditingController();

  CryptoModel? get getCryptoData => _cryptoData;

  bool isLoading = true;

  void updateSuggestionSelectedPair(String str) {
    _suggestionSelectedPair = str;
    update();
  }

  Future<void> getCryptoRate(String str) async {
    print("Line30");

    print("Line31");

    http.Response cryptoResponse = await http
        .get(Uri.parse("https://www.bitstamp.net/api/v2/ticker/$str"));
    print("Line32");
    // Get.back();
    print("Line33");
    if (cryptoResponse.statusCode == 200) {
      _cryptoData = cryptoModelFromJson(cryptoResponse.body);
      print("Line34");

      update();
    }
  }

  Future<void> getOrderBook() async {
    http.Response orderResponse = await http
        .get(Uri.parse("https://www.bitstamp.net/api/v2/order_book/btcusd"));
    if (orderResponse.statusCode == 200) {
      _orderData = orderBookModelFromJson(orderResponse.body);
      update();
    }
  }
}
