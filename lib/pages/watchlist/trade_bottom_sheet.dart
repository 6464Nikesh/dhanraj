import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/web_socket_service.dart';
import '../../utils/app_api_end_point.dart';

class TradeBottomSheet extends StatefulWidget {
  final Items? items;
  final String? lastPrice;
  final String? differentPercentage;
  final Color? color;

  const TradeBottomSheet({
    super.key,
    required this.items,
    required this.color,
    required this.lastPrice,
    required this.differentPercentage,
  });

  @override
  State<TradeBottomSheet> createState() => _TradeBottomSheetState();
}

class _TradeBottomSheetState extends State<TradeBottomSheet> {
  String orderType = 'MARKET';
  String selectedTrade = "BUY";
  final tradeLotController = TextEditingController();
  final stoplossController = TextEditingController();
  final limitController = TextEditingController();
  final marketController = TextEditingController();
  final targetController = TextEditingController();
  num totalQty = 0;
  num instrumentToken = 0;

  @override
  void initState() {
    // TODO: implement initState
    instrumentToken = int.tryParse(widget.items?.symbol?.instrumentToken ?? "0") ?? 0;
    super.initState();
  }

  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  bool validate(BuildContext context) {
    if (tradeLotController.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "Please enter trade lot", Colors.red, AppColors.red);
      return false;
    }

    if (orderType == "LIMIT") {
      if (limitController.text.trim().isEmpty) {
        AppWidget().snackBarTop(context, "Please enter limit price", Colors.red, AppColors.red);
        return false;
      }

      if (stoplossController.text.trim().isEmpty) {
        AppWidget().snackBarTop(context, "Please enter stop loss", Colors.red, AppColors.red);
        return false;
      }

      if (targetController.text.trim().isEmpty) {
        AppWidget().snackBarTop(context, "Please enter target", Colors.red, AppColors.red);
        return false;
      }
    }

    return true;
  }

  buyOrSell({required BuildContext context}) {
    if (validate(context) == false) {
      return;
    }
    var mapData = {
      "symbolId": widget.items?.symbol?.symbolId ?? "",
      "tradeType": selectedTrade,
      "trade_lot_size": num.parse(tradeLotController.text),
      "orderType": orderType,
      "remarks": "Quick market buy",
      "stoplossPrice": stoplossController.text,
      "takeprofitPrice": targetController.text,
      "openPrice": widget.lastPrice,
      "requiredMargin": 200,
      "originalMargin": 400
    };
    Networking().post(context: context, mapData: mapData, endPoint: AppApiEndPoint.position, isLoaderShow: true, fromBottomSheet: true).then(
      (value) {
        if (value != null) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${widget.items?.symbol?.name ?? ""}${removeTrailingZeros(widget.items?.symbol?.strike ?? "")} ${widget.items?.symbol?.instrumentType ?? ""}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Text(
                                    "${widget.items?.symbol?.segment}",
                                    style: const TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          Miscellaneous.dateConverterToDDMMMYYYY(widget.items?.symbol?.expiry ?? ""),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "roboto",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Selector<WebSocketService, Map?>(
                      selector: (_, ws) => ws.latestData[SubscriptionType.watchlist]?[instrumentToken],
                      builder: (_, data, __) {
                        if (data == null) return Text("Loading...");

                        String lastPrice = '00.00';
                        String changePercent = '00.00';
                        num change = 0;

                        Color priceColor = Colors.black;

                        if (data != null && data['instrument_token'] == instrumentToken) {
                          num price = data['last_price'] ?? 0;
                          num prevClose = data['ohlc']['close'] ?? 0;

                          change = price - prevClose;
                          num percent = (prevClose > 0) ? ((change / prevClose) * 100) : 0;

                          lastPrice = price.toString();
                          changePercent = '${percent.toStringAsFixed(2)}%';

                          if (change > 0) {
                            priceColor = Colors.green;
                          } else if (change < 0) {
                            priceColor = Colors.red;
                          } else {
                            priceColor = Colors.grey;
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              lastPrice,
                              style: TextStyle(
                                fontFamily: "roboto",
                                fontSize: 14,
                                color: priceColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  change.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontFamily: "roboto",
                                    fontSize: 10,
                                    color: priceColor,
                                  ),
                                ),
                                Text(
                                  " ($changePercent)",
                                  style: TextStyle(
                                    fontFamily: "roboto",
                                    fontSize: 10,
                                    color: priceColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        selectedTrade = "BUY";
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selectedTrade == "BUY" ? Colors.green : Colors.white,
                        side: const BorderSide(
                          color: Colors.green,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Buy',
                        style: TextStyle(
                          color: selectedTrade == "BUY" ? Colors.white : Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        selectedTrade = "SELL";
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selectedTrade == "SELL" ? Colors.red : Colors.white,
                        side: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Sell',
                        style: TextStyle(
                          color: selectedTrade == "SELL" ? Colors.white : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                      controller: tradeLotController,
                      onChanged: (val) {
                        num tradeLot = num.tryParse(val) ?? 0;
                        if (orderType == "MARKET") {
                          totalQty = tradeLot * num.parse(widget.lastPrice ?? "");
                        } else {
                          totalQty = tradeLot * num.parse(limitController.text);
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: AppStrings.enterTradeLot,
                        hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(text: totalQty.toString()),
                      style: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: AppStrings.totalQty,
                        hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: DropdownButtonFormField<String>(
                        value: orderType,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                          ),
                          isDense: true,
                        ),
                        items: ['MARKET', 'LIMIT'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontFamily: "roboto", fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            orderType = value!;
                            if (orderType == "MARKET") {
                              totalQty = num.parse(tradeLotController.text) * num.parse(widget.lastPrice ?? "");
                            } else {
                              totalQty = num.parse(tradeLotController.text) * num.parse(limitController.text);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: orderType == 'MARKET'
                        ? TextField(
                            controller: TextEditingController(text: widget.lastPrice),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "$orderType ${AppStrings.price}",
                              hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                            ),
                          )
                        : TextField(
                            controller: limitController,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              num tradeLot = num.tryParse(val) ?? 0;

                              totalQty = tradeLot * num.parse(limitController.text);

                              setState(() {});
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "$orderType ${AppStrings.price}",
                              hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      controller: stoplossController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: AppStrings.enterStopLoss,
                        hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: targetController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: AppStrings.entryTarget,
                        hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    buyOrSell(context: context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                  child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
        );
      },
    );
  }
}
