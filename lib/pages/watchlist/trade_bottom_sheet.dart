import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final targetController = TextEditingController();
  num totalQty = 0;

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
    } else if (orderType == "LIMIT" && limitController.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "Please enter limit", Colors.red, AppColors.red);
      return false;
    } else if (stoplossController.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "Please enter stop loss", Colors.red, AppColors.red);
      return false;
    } else if (targetController.text.trim().isEmpty) {
      AppWidget().snackBarTop(context, "Please enter target", Colors.red, AppColors.red);
      return false;
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
                  child: Column(
                    children: [
                      Text(
                        "${widget.items?.symbol?.name ?? ""}${removeTrailingZeros(widget.items?.symbol?.strike ?? "")} ${widget.items?.symbol?.instrumentType ?? ""}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'LTP: ${widget.lastPrice} | ${widget.differentPercentage}',
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 14,
                          fontFamily: "roboto",
                        ),
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
                          setState(() {
                            totalQty = tradeLot * num.parse(widget.lastPrice ?? "");
                          });
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
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        enabled: orderType == 'LIMIT',
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
            ),
          ),
        );
      },
    );
  }
}
