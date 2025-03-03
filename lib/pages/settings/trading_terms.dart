import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class TradingTerms extends StatefulWidget {
  const TradingTerms({super.key});

  @override
  State<TradingTerms> createState() => _TradingTermsState();
}

class _TradingTermsState extends State<TradingTerms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.tradingTerms),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NSE Futures",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Enabled",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "roboto",
                        color: AppColors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: List.generate(
                  3,
                  (index) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brokerage",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          "1250 per crore",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: const BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NSE Options",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Enabled",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "roboto",
                        color: AppColors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: List.generate(
                  3,
                  (index) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brokerage",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          "1250 per crore",
                          style: TextStyle(
                            fontFamily: "roboto",
                            color: AppColors.navyBlue,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
