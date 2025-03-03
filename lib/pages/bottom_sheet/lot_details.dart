import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class LotDetails extends StatefulWidget {
  const LotDetails({super.key});

  @override
  State<LotDetails> createState() => _LotDetailsState();
}

class _LotDetailsState extends State<LotDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NIFTY 19DEC24 24700 PE",
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
                        "NSE",
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        "168.00",
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 12,
                          color: AppColors.red,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "-4.65 (-2.80%)",
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
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton.colorButton(
                      text: AppStrings.buy,
                      context: context,
                      color: AppColors.green,
                      isActive: true,
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: AppButton.colorButton(
                      text: AppStrings.sell,
                      context: context,
                      color: AppColors.red,
                      isActive: true,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.grey,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            hintText: AppStrings.quantity,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.grey,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            hintText: AppStrings.entryPrice,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppStrings.timeFrame,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  const TextField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      hintText: AppStrings.transactionID,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.grey,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            hintText: AppStrings.stopLoss,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.grey,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            hintText: AppStrings.target,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(AppStrings.availableBalance),
                              Text(" : "),
                              Text("10000.000"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(AppStrings.charges),
                              Text(" : "),
                              Text("100.000"),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.refresh)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppButton.button(text: AppStrings.submit, context: context),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
