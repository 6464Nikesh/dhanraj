import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/margin_model.dart';
import '../../provider/deposit_withdrawal_sheet_provider.dart';
import '../../provider/provider_dashboard.dart';
import '../../provider/web_socket_service.dart';
import '../../utils/app_api_end_point.dart';
import '../../utils/choose_image_provider.dart';

class DepositWithdrawalSheet extends StatefulWidget {
  const DepositWithdrawalSheet({
    super.key,
  });

  @override
  State<DepositWithdrawalSheet> createState() => _DepositWithdrawalSheetState();
}

class _DepositWithdrawalSheetState extends State<DepositWithdrawalSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<DepositWithdrawalSheetProvider>(context, listen: false).getPrefData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DepositWithdrawalSheetProvider>(
      builder: (context, dsp, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dsp.selectedPage == "deposit"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "${AppStrings.deposit}/${AppStrings.withdrawal}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  dsp.changePage(value: "deposit");
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: dsp.selectedPage == "deposit" ? Colors.green : Colors.white,
                                  side: const BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                    color: dsp.selectedPage == "deposit" ? Colors.white : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  dsp.changePage(value: "withdrawal");
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: dsp.selectedPage == "withdrawal" ? Colors.red : Colors.white,
                                  side: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Withdrawal',
                                  style: TextStyle(
                                    color: dsp.selectedPage == "withdrawal" ? Colors.white : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("${AppStrings.funds} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                                controller: dsp.depositFundsController,
                                onChanged: (val) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: AppStrings.funds,
                                  hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                  ),
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            dsp.companyName == "NESTA CAPITAL"
                                ? Expanded(
                                    child: Consumer<ChooseImageProvider>(builder: (context, cip, child) {
                                      return TextField(
                                        onTap: () {
                                          cip.showBottomSheetChooseFile(context: context).then(
                                            (value) {
                                              if (value != null) {
                                                dsp.selSelectedFile(value);
                                              }
                                            },
                                          );
                                        },
                                        controller: dsp.fileController,
                                        readOnly: true,
                                        style: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                          ),
                                          suffixIcon: dsp.selectedFile != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    dsp.removeSelectedFile();
                                                  },
                                                  child: const Icon(Icons.cancel_outlined))
                                              : const Icon(Icons.upload),
                                          counterText: "",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        (dsp.companyName == "NESTA CAPITAL")
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("${AppStrings.transactionType} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                          ],
                                          controller: dsp.transactionTypeController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: AppStrings.transactionType,
                                            hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                            counterText: "",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("${AppStrings.transactionID} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextField(
                                          controller: dsp.transactionIdController,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                          ],
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: AppStrings.transactionID,
                                            hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                            counterText: "",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("${AppStrings.notes} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: dsp.depositNoteController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: AppStrings.notes,
                                hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                ),
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              dsp.addFunds(context: context);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                            child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "${AppStrings.deposit}/${AppStrings.withdrawal}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  dsp.changePage(value: "deposit");
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: dsp.selectedPage == "deposit" ? Colors.green : Colors.white,
                                  side: const BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                    color: dsp.selectedPage == "deposit" ? Colors.white : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  dsp.changePage(value: "withdrawal");
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: dsp.selectedPage == "withdrawal" ? Colors.red : Colors.white,
                                  side: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Withdrawal',
                                  style: TextStyle(
                                    color: dsp.selectedPage == "withdrawal" ? Colors.white : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("${AppStrings.funds} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                          controller: dsp.withdrawalFundsController,
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: AppStrings.funds,
                            hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("${AppStrings.notes} :", style: TextStyle(fontFamily: "roboto", fontSize: 14)),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: dsp.withdrawalNoteController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: AppStrings.notes,
                            hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              dsp.withdrawalFunds(context: context);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                            child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
