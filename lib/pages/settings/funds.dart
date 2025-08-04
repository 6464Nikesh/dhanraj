import 'package:dhanraj/provider/provider_funds.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bottom_sheet/deposit_withdrawal_sheet.dart';

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
                enableDrag: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const DepositWithdrawalSheet(),
                  );
                },
              );
            },
            backgroundColor: AppColors.darkBlue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _.transactions?.length,
              controller: _.scrollController,
              itemBuilder: (context, index) {
                final data = _.transactions?[index];

                Color color = AppColors.grey;

                if (data?.status == "DEPOSIT") {
                  color = AppColors.green;
                } else if (data?.status == "WITHDRAWAL") {
                  color = AppColors.red;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data?.transactionType ?? ""} (${data?.status ?? ""}) ",
                                      style: const TextStyle(
                                        fontFamily: "roboto",
                                        fontSize: 14,
                                        color: AppColors.navyBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Miscellaneous.dateConverterToDDMMMYYYYHHMM(data?.createdAt ?? ""),
                                      style: const TextStyle(
                                        fontFamily: "roboto",
                                        fontSize: 12,
                                        color: AppColors.grey,
                                      ),
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
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          child: Text(
                                            data?.amount ?? "",
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              fontSize: 14,
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data?.balance ?? "",
                                        style: const TextStyle(
                                          fontFamily: "roboto",
                                          color: AppColors.grey,
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
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
