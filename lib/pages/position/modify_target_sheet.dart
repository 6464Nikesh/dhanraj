import 'package:dhanraj/model/get_watchlist_items_model.dart';
import 'package:dhanraj/provider/position_provider.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../arguments/trade_detail_arg.dart';
import '../../model/margin_model.dart';
import '../../provider/web_socket_service.dart';
import '../../utils/app_api_end_point.dart';
import '../../utils/app_appbar.dart' show AppAppbar;
import '../../utils/app_button.dart';

class ModifyTargetSheet extends StatefulWidget {
  final TradeDetailArg arg;

  const ModifyTargetSheet({super.key, required this.arg});

  @override
  State<ModifyTargetSheet> createState() => _ModifyTargetSheetState();
}

class _ModifyTargetSheetState extends State<ModifyTargetSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PositionProvider>(
      builder: (context, pp, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.modifyTarget,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                        widget.arg.trades?.tradingsymbol ?? "",
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
                        "Current Target",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.arg.trades?.takeprofitPrice ?? "--",
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
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                    controller: pp.newTargetController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppStrings.newTarget,
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
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      pp.updateTarget(
                        context: context,
                        newTarget: pp.newTargetController.text.toString(),
                        tradeId: widget.arg.trades?.id.toString() ?? "",
                      );
                    },
                    child: AppButton.button(
                      text: AppStrings.update,
                      context: context,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }
}
