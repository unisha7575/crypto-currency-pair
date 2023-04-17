

import 'dart:convert';

OrderBookModel orderBookModelFromJson(String str) => OrderBookModel.fromJson(json.decode(str));

String orderBookModelToJson(OrderBookModel data) => json.encode(data.toJson());

class OrderBookModel {
  OrderBookModel({
    required this.timestamp,
    required this.microtimestamp,
    required this.bids,
    required this.asks,
  });

  String timestamp;
  String microtimestamp;
  List<List<String>> bids;
  List<List<String>> asks;

  factory OrderBookModel.fromJson(Map<String, dynamic> json) => OrderBookModel(
    timestamp: json["timestamp"],
    microtimestamp: json["microtimestamp"],
    bids: List<List<String>>.from(json["bids"].map((x) => List<String>.from(x.map((x) => x)))),
    asks: List<List<String>>.from(json["asks"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "microtimestamp": microtimestamp,
    "bids": List<dynamic>.from(bids.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "asks": List<dynamic>.from(asks.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
