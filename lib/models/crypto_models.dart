import 'dart:convert';

CryptoModel cryptoModelFromJson(String str) => CryptoModel.fromJson(json.decode(str));

String cryptoModelToJson(CryptoModel data) => json.encode(data.toJson());

class CryptoModel {
  CryptoModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.last,
    required this.volume,
    required this.vwap,
    required this.bid,
    required this.ask,
    required this.open24,
    required this.percentChange24,
  });

  String timestamp;
  String open;
  String high;
  String low;
  String last;
  String volume;
  String vwap;
  String bid;
  String ask;
  String open24;
  String percentChange24;

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
    timestamp: json["timestamp"],
    open: json["open"],
    high: json["high"],
    low: json["low"],
    last: json["last"],
    volume: json["volume"],
    vwap: json["vwap"],
    bid: json["bid"],
    ask: json["ask"],
    open24: json["open_24"],
    percentChange24: json["percent_change_24"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "open": open,
    "high": high,
    "low": low,
    "last": last,
    "volume": volume,
    "vwap": vwap,
    "bid": bid,
    "ask": ask,
    "open_24": open24,
    "percent_change_24": percentChange24,
  };
}
