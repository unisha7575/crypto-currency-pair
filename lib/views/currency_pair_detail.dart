import 'package:crypto_demo_project/controller/crypto_controller.dart';
import 'package:crypto_demo_project/models/crypto_models.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyPairDetail extends StatefulWidget {
  const CurrencyPairDetail({Key? key}) : super(key: key);

  @override
  State<CurrencyPairDetail> createState() => _CurrencyPairDetailState();
}

class _CurrencyPairDetailState extends State<CurrencyPairDetail> {
  TextEditingController _typeAheadController = TextEditingController();

  final CryptoController cryptoController = Get.put(CryptoController());

  //final CryptoController controller = Get.put(CryptoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          GetBuilder<CryptoController>(builder: (logic) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    autofocus: false,
                    decoration: const InputDecoration(
                        hintText: "Enter currency pair",
                        border: OutlineInputBorder())),
                suggestionsCallback: (pattern) async {
                  return logic.getCurrencyPair
                      .where((u) => u.contains(pattern))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString().toUpperCase()),
                  );
                },
                onSuggestionSelected: (suggestion) async {
                  Get.dialog(Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ));
                  cryptoController.updateSuggestionSelectedPair(suggestion);
                  await cryptoController.getCryptoRate(suggestion);
                  Get.back();
                },
              ),
            );
          }),
          GetBuilder<CryptoController>(
            builder: (logic) {
              if ((logic.getCryptoData == null)) {
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Icon(Icons.search,
                            size: 340, color: Colors.black.withOpacity(0.6)),
                        const Text(
                          "Enter a currency pair to load data",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GetBuilder<CryptoController>(builder: (logic) {
                                return Text(
                                  (logic.getSuggestionSelectedPair.isEmpty)
                                      ? "BTCUSD"
                                      : logic.getSuggestionSelectedPair
                                          .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                );
                              }),
                              const Spacer(),
                              Text(
                                DateTime.fromMillisecondsSinceEpoch(int.parse(
                                        logic.getCryptoData!.timestamp))
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Open",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                      "\$ ${logic.getCryptoData!.open.toString()}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ],
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "High",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  //  Text(logic.getCryptoData!.high.toString(),

                                  Text(
                                      "\$ ${logic.getCryptoData!.high.toString()}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Low",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                        "\$ ${logic.getCryptoData!.low.toString()}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(
                                  width: 120,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Last",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                        "\$ ${logic.getCryptoData!.last.toString()} ",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Volume",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(logic.getCryptoData!.volume.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<CryptoController>(builder: (logic) {
                            return InkWell(
                                onTap: () async {
                                  await cryptoController.getOrderBook();
                                  cryptoController.isClicked =
                                      !cryptoController.isClicked;
                                },
                                child: (cryptoController.isClicked)
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "VIEW ORDER BOOK",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purpleAccent[700],
                                              fontWeight: FontWeight.w600),
                                        ))
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "HIDE ORDER BOOK",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purpleAccent[700],
                                              fontWeight: FontWeight.w600),
                                        )));
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "ORDER BOOK",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          GetBuilder<CryptoController>(builder: (logic) {
                            return (cryptoController.isClicked)
                                ? const SizedBox()
                                : Card(
                                    elevation: 3, // Change this
                                    shadowColor: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                "BID PRICE",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[0][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[1][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[2][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[3][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[4][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "Qty",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 13,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[0][1]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[1][1]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[2][1]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[3][1]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.bids[4][1]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Qty",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Text(
                                                  logic.getOrderData!.bids[1][1]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Text(
                                                  logic.getOrderData!.bids[2][1]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Text(
                                                  logic.getOrderData!.bids[3][1]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Text(
                                                  logic.getOrderData!.bids[4][1]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Text(
                                                  logic.getOrderData!.bids[5][1]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "ASK PRICE",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.asks[0][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.asks[1][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.asks[2][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.asks[3][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                logic.getOrderData!.asks[4][0]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          })
                        ]));
              }
            },
          ),
        ]),
      ),
    );
  }
}
