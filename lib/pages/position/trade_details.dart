import 'package:dhanraj/pages/bottom_sheet/modify_trade.dart';
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
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.position),
      body: Column(
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
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Net P&L: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "roboto",
                                ),
                              ),
                              Text(
                                "+₹ 30.00  (+5.7%)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.green,
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
                          "Instrument",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.symbolName}${Provider.of<PositionProvider>(context, listen: false).removeTrailingZeros(widget.arg.trades?.strike ?? "")} ${widget.arg.trades?.instrumentType ?? ""}",
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
                          "Status",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.status}",
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
                        Text(
                          "Quantity",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.arg.trades?.symbolLotSize}",
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
                     Row(
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
                          "NEED TO ASK",
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
                     Row(
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
                          "${widget.arg.trades?.openPrice}",
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
                     Row(
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
                          "${widget.arg.trades?.stoplossPrice}",
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
                     Row(
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
                          "${Miscellaneous.dateConverterToDDMMMYYYY(widget.arg.trades?.expiry ?? "")}",
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
                    )
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
                    child: AppButton.colorButton(
                      text: AppStrings.exitTrade,
                      context: context,
                      color: AppColors.red,
                      isActive: true,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
