import 'package:dhanraj/provider/position_provider.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../arguments/trade_detail_arg.dart';

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
        Provider.of<PositionProvider>(context, listen: false).getPositionList(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PositionProvider>(builder: (context, pp, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkBlue,
              ),
              child: const Center(
                child: Text(
                  "S",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "roboto",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          title: const Text(
            AppStrings.position,
            style: TextStyle(
              fontFamily: "roboto",
              color: AppColors.navyBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "₹ 10,63,917.80",
                          style: TextStyle(
                            fontFamily: "roboto",
                            fontSize: 18,
                            color: AppColors.navyBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.totalPortfolio,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "₹ 00.00",
                          style: TextStyle(
                            fontFamily: "roboto",
                            fontSize: 18,
                            color: AppColors.navyBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Net Unrealised P&L',
                          style: TextStyle(
                            fontFamily: "roboto",
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
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
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.availableMargin,
                            style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹10,63,917.80",
                            style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.investedMargin,
                            style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹00.00",
                            style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
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
                  pp.trades.length,
                  (index) {
                    var data = pp.trades[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          TradeDetailArg arg = TradeDetailArg(trades: data);

                          Navigator.pushNamed(context, AppRoutes.tradeDetails, arguments: arg);
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
                                            fontSize: 8,
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
                                        fontSize: 12,
                                        color: AppColors.grey,
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
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
