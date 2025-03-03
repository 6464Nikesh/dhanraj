import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class HistoryTradeDetails extends StatefulWidget {
  const HistoryTradeDetails({super.key});

  @override
  State<HistoryTradeDetails> createState() => _HistoryTradeDetailsState();
}

class _HistoryTradeDetailsState extends State<HistoryTradeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.green,
        shape: const CircleBorder(),
        child: Image.asset(AppAssets.whatsapp,scale: 1,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(
                      child: Text(
                        "@devang151",
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 18,
                          color: AppColors.navyBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.yellow),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.stars_rounded,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.active,
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  AppStrings.premium,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Net P&L: ",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.grey, fontFamily: "roboto"),
                              ),
                              Text(
                                "+₹ 30.00  (+5.7%)",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.green, fontFamily: "roboto"),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Instrument",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "NIFTY 05DEC24 24400 CE",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "+100",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LTP",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "149.80 (-3.29%)",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entry Price",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "149.50",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stoploss",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "--",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Target",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "--",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Validity till",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "5 Dec 24, 3:20 PM",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Margin Used",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "14,950.00",
                          style: TextStyle(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Est. Charges",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "--",
                          style: TextStyle(
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
                    RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'NIFTY 05DEC24 24400 CE',
                            style: TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' approx. price when trade was placed : 149.50',
                            style: TextStyle(
                              fontFamily: "roboto",
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Order Logs",
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blue, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "(Buy) Trade Placed",
                                          style: TextStyle(
                                            fontFamily: "roboto",
                                            fontSize: 12,
                                            color: AppColors.navyBlue,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "12:26 AM",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "04/12/24",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.navyBlue,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Price: 149.00",
                                    style: TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 12,
                                      color: AppColors.navyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blue, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Target Modify",
                                          style: TextStyle(
                                            fontFamily: "roboto",
                                            fontSize: 12,
                                            color: AppColors.navyBlue,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "12:26 AM",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "04/12/24",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.navyBlue,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "New Target: 149.00",
                                    style: TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 12,
                                      color: AppColors.navyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blue, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Target Modify",
                                          style: TextStyle(
                                            fontFamily: "roboto",
                                            fontSize: 12,
                                            color: AppColors.navyBlue,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "12:26 AM",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "04/12/24",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.navyBlue,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "New Target: 149.00",
                                    style: TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 12,
                                      color: AppColors.navyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blue, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "(Sell) Trade Closed",
                                          style: TextStyle(
                                            fontFamily: "roboto",
                                            fontSize: 12,
                                            color: AppColors.navyBlue,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "12:26 AM",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "04/12/24",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.navyBlue,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Exited: 148.78",
                                    style: TextStyle(
                                      fontFamily: "roboto",
                                      fontSize: 12,
                                      color: AppColors.navyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
