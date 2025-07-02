import 'dart:io';

import 'package:dhanraj/provider/deposit_withdrawal_sheet_provider.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/choose_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DepositWithdrawal extends StatefulWidget {
  const DepositWithdrawal({super.key});

  @override
  State<DepositWithdrawal> createState() => _DepositWithdrawalState();
}

class _DepositWithdrawalState extends State<DepositWithdrawal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<DepositWithdrawalSheetProvider>(builder: (context, bsp, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "${AppStrings.deposit}/${AppStrings.withdrawal}",
                  style: TextStyle(
                    fontFamily: "roboto",
                    fontSize: 18,
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          bsp.changePage(value: "deposit");
                        },
                        child: AppButton.colorButton(
                          text: AppStrings.deposit,
                          context: context,
                          color: bsp.selectedPage == "deposit" ? AppColors.green : AppColors.green.withOpacity(0.2),
                          isActive: true,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          bsp.changePage(value: "withdrawal");
                        },
                        child: AppButton.colorButton(
                          text: AppStrings.withdrawal,
                          context: context,
                          color: bsp.selectedPage == "deposit" ? AppColors.red.withOpacity(0.2) : AppColors.red,
                          isActive: true,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bsp.selectedPage == "deposit"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: bsp.depositFundsController,
                                  cursorColor: AppColors.grey,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    hintText: AppStrings.amount,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Consumer<ChooseImageProvider>(builder: (context, cip, child) {
                                  return TextField(
                                    readOnly: true,
                                    onTap: () {
                                      cip.showBottomSheetChooseFile(context: context).then(
                                        (value) {
                                          if (value != null) {
                                            bsp.selSelectedFile(value as File);
                                          }
                                        },
                                      );
                                    },
                                    cursorColor: AppColors.grey,
                                    controller: bsp.fileController,
                                    decoration: InputDecoration(
                                      suffixIcon: bsp.selectedFile != null
                                          ? GestureDetector(
                                              onTap: () {
                                                bsp.removeSelectedFile();
                                              },
                                              child: const Icon(Icons.cancel_outlined))
                                          : const Icon(Icons.upload),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.grey),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.grey),
                                      ),
                                      hintText: AppStrings.screenShot,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "roboto",
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: bsp.depositNoteController,
                            cursorColor: AppColors.grey,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              hintText: AppStrings.notes,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                              onTap: () {
                                bsp.addFunds(context: context);
                              },
                              child: AppButton.button(
                                text: AppStrings.submit,
                                context: context,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: bsp.withdrawalFundsController,
                                  cursorColor: AppColors.grey,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    hintText: AppStrings.amount,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: bsp.withdrawalNoteController,
                            cursorColor: AppColors.grey,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              hintText: AppStrings.notes,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
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
                          GestureDetector(
                              onTap: () {
                                bsp.withdrawalFunds(context: context);
                              },
                              child: AppButton.button(
                                text: AppStrings.submit,
                                context: context,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
