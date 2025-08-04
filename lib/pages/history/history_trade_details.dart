import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../arguments/trade_detail_arg.dart';
import '../../utils/miscellaneous.dart';

class HistoryTradeDetails extends StatefulWidget {
  final TradeDetailArg arg;

  const HistoryTradeDetails({super.key, required this.arg});

  @override
  State<HistoryTradeDetails> createState() => _HistoryTradeDetailsState();
}

class _HistoryTradeDetailsState extends State<HistoryTradeDetails> {
  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.history),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Net P&L: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "roboto",
                                ),
                              ),
                              Text(
                                widget.arg.trades?.profitLoss ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "roboto",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Trade details",
                      style: TextStyle(
                        fontFamily: "roboto",
                        color: AppColors.navyBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Symbol",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.symbolName ?? ""}${removeTrailingZeros(widget.arg.trades?.strike ?? "")} ${widget.arg.trades?.instrumentType}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Exchange",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.exchange}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Segment",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.segment}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Type",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.tradeType}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.quantity}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Open Price",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.openPrice}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Close Price",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.closePrice}",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Open at",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          Miscellaneous.dateConverterToDDMMMYYYY(widget.arg.trades?.execution?.executionTime ?? ""),
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Closed at",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          Miscellaneous.dateConverterToDDMMMYYYY(widget.arg.trades?.expiry ?? ""),
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Margin Used",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.arg.trades?.requiredMargin?.toStringAsFixed(2) ?? "",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Est. Charges",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.arg.trades?.brokerage ?? "",
                          style: const TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
