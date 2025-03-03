import 'package:dhanraj/pages/bottom_sheet/lot_details.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:flutter/material.dart';

class BankNifty extends StatefulWidget {
  const BankNifty({super.key});

  @override
  State<BankNifty> createState() => _BankNiftyState();
}

class _BankNiftyState extends State<BankNifty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: List.generate(
          3,
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const LotDetails(),
                      );
                    },
                  );
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
    );
  }
}
