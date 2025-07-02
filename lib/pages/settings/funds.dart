import 'package:dhanraj/pages/bottom_sheet/deposit_withdrawal.dart';
import 'package:dhanraj/provider/provider_funds.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Funds extends StatefulWidget {
  const Funds({super.key});

  @override
  State<Funds> createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderFunds>(context, listen: false).getTransactionHistory(context);
        Provider.of<ProviderFunds>(context, listen: false).scrollController.addListener(Provider.of<ProviderFunds>(context, listen: false).onScroll(context));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFunds>(
      builder: (context, _, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppAppbar.appBar(AppStrings.funds),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const DepositWithdrawal(),
                  );
                },
              );
            },
            backgroundColor: AppColors.darkBlue,
            child: const Icon(
              Icons.edit_document,
              color: Colors.white,
            ),
          ),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _.transactions?.length,
                    controller: _.scrollController,
                    itemBuilder: (context, index) {
                      final data = _.transactions?[index];
                      return data?.transactionType == "DEPOSIT"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade100,
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
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
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
                                                data?.user?.userName ?? "",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 14,
                                                  color: AppColors.navyBlue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "₹ ${data?.amount ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 14,
                                                  color: AppColors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data?.user?.fullName ?? "",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 12,
                                                  color: AppColors.grey,
                                                ),
                                              ),
                                              Text(
                                                data?.transactionType ?? "",
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
                                          Text(
                                            Miscellaneous.dateConverterWithDay(data?.createdAt ?? ""),
                                            style: const TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade100,
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
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
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
                                                data?.user?.userName ?? "",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 14,
                                                  color: AppColors.navyBlue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "- ₹ ${data?.amount ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 14,
                                                  color: AppColors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data?.user?.fullName ?? "",
                                                style: const TextStyle(
                                                  fontFamily: "roboto",
                                                  fontSize: 12,
                                                  color: AppColors.grey,
                                                ),
                                              ),
                                              Text(
                                                data?.transactionType ?? "",
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
                                          Text(
                                            Miscellaneous.dateConverterWithDay(data?.createdAt ?? ""),
                                            style: const TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 12,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
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
      },
    );
  }
}
