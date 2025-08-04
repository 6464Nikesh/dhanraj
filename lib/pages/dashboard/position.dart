import 'package:dhanraj/provider/position_provider.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../arguments/trade_detail_arg.dart';
import '../../provider/web_socket_service.dart';

class Position extends StatefulWidget {
  const Position({super.key});

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<PositionProvider>(context, listen: false).init(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PositionProvider, WebSocketService>(
      builder: (context, pp, ws, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: () async {
                pp.init(context: context);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${pp.margin.toStringAsFixed(2)} (${pp.latestBalance.toStringAsFixed(2)})",
                                style: const TextStyle(
                                  fontFamily: "roboto",
                                  fontSize: 18,
                                  color: AppColors.navyBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Row(
                                children: [
                                  Text(
                                    AppStrings.margin,
                                    style: TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    size: 18,
                                    color: AppColors.grey,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppStrings.totalPortfolio,
                                  style: TextStyle(fontFamily: "roboto", fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  pp.netBalanceWithPnl.toStringAsFixed(2),
                                  style: const TextStyle(fontFamily: "roboto", fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
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
                                  "P&L (running)",
                                  style: TextStyle(fontFamily: "roboto", fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  pp.totalPnl.toStringAsFixed(2),
                                  style: const TextStyle(fontFamily: "roboto", fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: List.generate(
                            pp.trades.length,
                            (index) {
                              var data = pp.trades[index];
                              print(data.toJson());

                              int? instrumentToken = int.tryParse(data.instrumentToken ?? '');
                              final symbol = data.symbolName?.toUpperCase();
                              final multiplier = pp.commodityMultipliers[symbol] ?? 1;
                              final isBuy = data.tradeType == 'BUY';
                              final quantity = data.quantity ?? 1;
                              num totalPnl = 0;

                              final socketData = ws.latestData[SubscriptionType.data]?[instrumentToken];

                              String pnlText = "00.00";
                              String percentText = "0.00%";
                              Color pnlColor = Colors.grey;
                              num lastPrice = 0;

                              if (socketData != null && socketData['instrument_token'] == instrumentToken) {
                                lastPrice = num.parse(socketData['last_price'].toString() ?? "0");
                                final openPrice = num.parse(data.openPrice.toString() ?? "0");

                                final priceDiff = isBuy ? lastPrice - openPrice : openPrice - lastPrice;

                                final pnl = priceDiff * quantity * multiplier;
                                pnlText = pnl.toStringAsFixed(2);

                                final percentChange = openPrice > 0 ? (priceDiff / openPrice) * 100 : 0;
                                percentText = "${percentChange.toStringAsFixed(2)}%";
                                totalPnl += pnl;
                                pp.updatePnl(totalPnl);

                                if (pnl > 0) {
                                  pnlColor = Colors.green;
                                } else if (pnl < 0) {
                                  pnlColor = Colors.red;
                                } else {
                                  pnlColor = Colors.grey;
                                }
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: GestureDetector(
                                  onTap: () async {
                                    TradeDetailArg arg = TradeDetailArg(trades: data);

                                    await Navigator.pushNamed(context, AppRoutes.tradeDetails, arguments: arg).then(
                                      (value) {
                                        if (value != null) {
                                          pp.initData(context: context);
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: const Offset(
                                            2.0,
                                            2.0,
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
                                      border: Border.all(color: AppColors.grey.withOpacity(0.2)),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${data.symbolName}${pp.removeTrailingZeros(data.strike ?? "")} ${data.instrumentType ?? ""}",
                                                      style: const TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 14,
                                                        color: AppColors.navyBlue,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(2),
                                                        child: Text(
                                                          "${data.segment}",
                                                          style: const TextStyle(
                                                            fontFamily: "roboto",
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      Miscellaneous.dateConverterToDDMMMYYYY(data.expiry ?? ""),
                                                      style: const TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${data.quantity} • (${data.tradeType?[0].toUpperCase()}) • ${data.openPrice}",
                                                      style: const TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 14,
                                                        color: AppColors.navyBlue,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(width: 4),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    pnlText,
                                                    style: TextStyle(
                                                      fontFamily: "roboto",
                                                      fontSize: 14,
                                                      color: pnlColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    percentText,
                                                    style: TextStyle(
                                                      fontFamily: "roboto",
                                                      fontSize: 10,
                                                      color: pnlColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    lastPrice.toStringAsFixed(2),
                                                    style: const TextStyle(
                                                      fontFamily: "roboto",
                                                      fontSize: 14,
                                                      color: AppColors.navyBlue,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        pp.pendingTrades.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.grey.withOpacity(0.1),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Pending Orders",
                                        style: TextStyle(fontFamily: "roboto", fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Column(
                                    children: List.generate(
                                      pp.pendingTrades.length,
                                      (index) {
                                        var data = pp.pendingTrades[index];

                                        int? instrumentToken = int.tryParse(data.instrumentToken ?? '');
                                        final symbol = data.symbolName?.toUpperCase();
                                        final multiplier = pp.commodityMultipliers[symbol] ?? 1;
                                        final isBuy = data.tradeType == 'BUY';
                                        final quantity = data.quantity ?? 1;

                                        final socketData = ws.latestData[SubscriptionType.data]?[instrumentToken];

                                        String pnlText = "00.00";
                                        String percentText = "0.00%";
                                        Color pnlColor = Colors.grey;
                                        num lastPrice = 0;

                                        if (socketData != null && socketData['instrument_token'] == instrumentToken) {
                                          lastPrice = num.parse(socketData['last_price'].toString() ?? "0");
                                          final openPrice = num.parse(data.openPrice.toString() ?? "0");

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

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: GestureDetector(
                                            onTap: () async {
                                              TradeDetailArg arg = TradeDetailArg(trades: data);

                                              await Navigator.pushNamed(context, AppRoutes.tradeDetails, arguments: arg).then(
                                                (value) {
                                                  if (value != null) {
                                                    pp.initData(context: context);
                                                  }
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    offset: const Offset(
                                                      2.0,
                                                      2.0,
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
                                                border: Border.all(color: AppColors.grey.withOpacity(0.2)),
                                                color: Colors.white,
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${data.symbolName}${pp.removeTrailingZeros(data.strike ?? "")} ${data.instrumentType ?? ""}",
                                                                style: const TextStyle(
                                                                  fontFamily: "roboto",
                                                                  fontSize: 14,
                                                                  color: AppColors.navyBlue,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(2),
                                                                  child: Text(
                                                                    "${data.segment}",
                                                                    style: const TextStyle(
                                                                      fontFamily: "roboto",
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                Miscellaneous.dateConverterToDDMMMYYYY(data.expiry ?? ""),
                                                                style: const TextStyle(
                                                                  fontFamily: "roboto",
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${data.quantity} • (${data.tradeType?[0].toUpperCase()}) • ${data.openPrice}",
                                                                style: const TextStyle(
                                                                  fontFamily: "roboto",
                                                                  fontSize: 14,
                                                                  color: AppColors.navyBlue,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "",
                                                          style: TextStyle(
                                                            fontFamily: "roboto",
                                                            fontSize: 14,
                                                            color: pnlColor,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "",
                                                          style: TextStyle(
                                                            fontFamily: "roboto",
                                                            fontSize: 10,
                                                            color: pnlColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          lastPrice.toStringAsFixed(2),
                                                          style: const TextStyle(
                                                            fontFamily: "roboto",
                                                            fontSize: 14,
                                                            color: AppColors.navyBlue,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
