import 'package:dhanraj/pages/bottom_sheet/deposit_withdrawal.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          AppStrings.history,
          style: const TextStyle(
            fontFamily: "roboto",
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            color: AppColors.navyBlue,
            onPressed: () {},
            icon: const Icon(Icons.arrow_downward),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: AppColors.darkBlue,
        child: const Icon(
          Icons.edit_document,
          color: Colors.white,
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
                    3,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.historyTradeDetails);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(
                                    5.0,
                                    5.0,
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
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "NIFTY 19DEC24 24700 PE",
                                        style: TextStyle(
                                          fontFamily: "roboto",
                                          fontSize: 14,
                                          color: AppColors.navyBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "-3,359.87",
                                        style: TextStyle(
                                          fontFamily: "roboto",
                                          fontSize: 14,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "100 Qty (B) . Active",
                                        style: TextStyle(
                                          fontFamily: "roboto",
                                          fontSize: 12,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      Text(
                                        "(-16.74%)",
                                        style: TextStyle(
                                          fontFamily: "roboto",
                                          fontSize: 12,
                                          color: AppColors.green,
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
            ),
          ],
        ),
      ),
    );
  }
}
