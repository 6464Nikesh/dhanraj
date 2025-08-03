import 'package:dhanraj/provider/provider_history.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../arguments/trade_detail_arg.dart';
import '../../provider/position_provider.dart';
import '../../provider/provider_dashboard.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderHistory>(context, listen: false).fetchSymbols(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderHistory>(builder: (context, ph, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ph.netPnl.toStringAsFixed(2),
                            style: const TextStyle(
                              fontFamily: "roboto",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Net P&L",
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
                          const SizedBox(
                            height: 20,
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
                                        AppStrings.realisedPL,
                                        style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        ph.realisedPnl.toStringAsFixed(2),
                                        style: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppStrings.unrealisedPL,
                                        style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "00.00",
                                        style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
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
                                        AppStrings.brokerage,
                                        style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        ph.totalBrokerage.toStringAsFixed(2),
                                        style: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
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
                            children: List.generate(
                              ph.trades.length,
                              (index) {
                                var data = ph.trades[index];
                                Color pnlColor = Colors.grey;

                                final multiplier = Provider.of<PositionProvider>(context, listen: false).commodityMultipliers[data.symbolName] ?? 1;
                                // Parse prices as numbers
                                final open = num.tryParse(data.openPrice ?? '0') ?? 0;
                                final close = num.tryParse(data.closePrice ?? '0') ?? 0;
                                final qty = data.quantity ?? 0;
                                final isBuy = data.tradeType?.toUpperCase() == 'BUY';

                                final pnl = isBuy ? (close - open) * qty * multiplier : (open - close) * qty * multiplier;

                                final percentChange = open != 0 ? (pnl / (open * qty)) * 100 : 0;

                                if (pnl > 0) {
                                  pnlColor = Colors.green;
                                } else if (pnl < 0) {
                                  pnlColor = Colors.red;
                                } else {
                                  pnlColor = Colors.grey;
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      TradeDetailArg arg = TradeDetailArg(trades: data);
                                      Navigator.pushNamed(context, AppRoutes.historyTradeDetails, arguments: arg);
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
                                                        "${data.symbolName}${ph.removeTrailingZeros(data?.strike ?? "")} ${data?.instrumentType ?? ""}",
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
                                                      pnl.toStringAsFixed(2),
                                                      style: TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 14,
                                                        color: pnl >= 0 ? AppColors.green : AppColors.red,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${percentChange.toStringAsFixed(2)}%",
                                                      style: TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 10,
                                                        color: pnl >= 0 ? AppColors.green : AppColors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      data.closePrice ?? "0",
                                                      style: const TextStyle(
                                                        fontFamily: "roboto",
                                                        fontSize: 14,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
