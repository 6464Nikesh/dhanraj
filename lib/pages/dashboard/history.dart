import 'package:dhanraj/pages/bottom_sheet/deposit_withdrawal.dart';
import 'package:dhanraj/provider/provider_history.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            AppStrings.history,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "₹ 61,252.63 (6.13%)",
                    style: TextStyle(
                      fontFamily: "roboto",
                      fontSize: 18,
                      color: AppColors.green,
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
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.realisedPL,
                                style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "₹10,63,917.80",
                                style: TextStyle(fontFamily: "roboto", fontSize: 14, color: AppColors.green, fontWeight: FontWeight.w600),
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
                                AppStrings.unrealisedPL,
                                style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "₹00.00",
                                style: TextStyle(fontFamily: "roboto", fontSize: 14, color: AppColors.green, fontWeight: FontWeight.w600),
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
                                AppStrings.estCharges,
                                style: TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "₹367.00",
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
                      ph.trades.length,
                          (index) {
                        var data = ph.trades[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.tradeDetails);
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
            ],
          ),
        ),
      );
    });
  }
}
