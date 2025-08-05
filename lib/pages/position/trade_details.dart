import 'package:dhanraj/pages/bottom_sheet/modify_trade.dart';
import 'package:dhanraj/pages/position/modify_stop_loss_sheet.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../arguments/trade_detail_arg.dart';
import '../../model/position_model.dart';
import '../../provider/position_provider.dart';
import '../../provider/web_socket_service.dart';
import 'exit_trade_dialogs.dart';
import 'modify_target_sheet.dart';

class TradeDetails extends StatefulWidget {
  final TradeDetailArg arg;

  const TradeDetails({super.key, required this.arg});

  @override
  State<TradeDetails> createState() => _TradeDetailsState();
}

class _TradeDetailsState extends State<TradeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.position),
      body: Consumer<WebSocketService>(builder: (context, ws, _) {
        int? instrumentToken = int.tryParse(widget.arg.trades?.instrumentToken ?? '');
        final symbol = widget.arg.trades?.symbolName?.toUpperCase();
        final multiplier = Provider.of<PositionProvider>(context).commodityMultipliers[symbol] ?? 1;
        final isBuy = widget.arg.trades?.tradeType == 'BUY';
        final quantity = widget.arg.trades?.quantity ?? 0;

        final socketData = ws.latestData[instrumentToken];

        String pnlText = "00.00";
        String percentText = "0.00%";
        Color pnlColor = Colors.grey;
        num lastPrice = 0;

        if (socketData != null && socketData['instrument_token'] == instrumentToken) {
          lastPrice = num.parse(socketData['last_price'].toString() ?? "0");
          final openPrice = num.parse(widget.arg.trades?.openPrice.toString() ?? "0");

          final priceDiff = isBuy ? lastPrice - openPrice : openPrice - lastPrice;

          final pnl = priceDiff * quantity * multiplier;
          pnlText = pnl.toStringAsFixed(2);

          final percentChange = openPrice > 0 ? (priceDiff / openPrice) * 100 : 0;
          percentText = "${percentChange.toStringAsFixed(2)}%";

          if (pnl > 0) {
            pnlColor = Colors.green;
          } else if (pnl < 0) {
            pnlColor = Colors.red;
          } else {
            pnlColor = Colors.grey;
          }
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                  pnlText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: pnlColor,
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
                            "${widget.arg.trades?.symbolName ?? ""}${ws.removeTrailingZeros(widget.arg.trades?.strike ?? "")} ${widget.arg.trades?.instrumentType}",
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
                            "LTP",
                            style: TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            lastPrice.toStringAsFixed(2),
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
                            "Target",
                            style: TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.arg.trades?.takeprofitPrice ?? "--",
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
                            "Stop loss",
                            style: TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.arg.trades?.stoplossPrice ?? "--",
                            style: const TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.navyBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                            "Validate till",
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
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(
                      -5.0,
                      -5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return const ModifyTrade();
                            },
                          ).then(
                            (value) {
                              if (value != null) {
                                if (value == 1) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: true,
                                    backgroundColor: Colors.white,
                                    requestFocus: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: SingleChildScrollView(
                                        child: ModifyTargetSheet(
                                          arg: widget.arg,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (value == 2) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: true,
                                    requestFocus: true,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: SingleChildScrollView(
                                        child: ModifyStopLossSheet(
                                          arg: widget.arg,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                        child: AppButton.colorButton(
                          text: AppStrings.modifyTrade,
                          context: context,
                          color: AppColors.navyBlue,
                          isActive: true,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ExitTradeDialogs(
                                onTap: () {
                                  Navigator.pop(context);
                                  Provider.of<PositionProvider>(context, listen: false)
                                      .exitTrade(context: context, ltp: lastPrice.toStringAsFixed(2), tradeId: widget.arg.trades?.id.toString() ?? "");
                                },
                              );
                            },
                          );
                        },
                        child: AppButton.colorButton(
                          text: AppStrings.exitTrade,
                          context: context,
                          color: AppColors.red,
                          isActive: true,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
