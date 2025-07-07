import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewWatchlistBottomSheet extends StatefulWidget {
  const CreateNewWatchlistBottomSheet({super.key});

  @override
  State<CreateNewWatchlistBottomSheet> createState() => _CreateNewWatchlistBottomSheetState();
}

class _CreateNewWatchlistBottomSheetState extends State<CreateNewWatchlistBottomSheet> {
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
              child: Text(
                AppStrings.createNewWatchlist,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "${AppStrings.watchlistName} :",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w700,
                      color: AppColors.grey,
                    ),
                  ),
                  TextField(
                    controller: Provider.of<ProviderWatchlist>(context, listen: false).name,
                    cursorColor: AppColors.grey,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      hintText: AppStrings.enterName,
                      hintStyle: TextStyle(
                        fontSize: 10,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // const Text(
                  //   "${AppStrings.description} :",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontFamily: "roboto",
                  //     fontWeight: FontWeight.w700,
                  //     color: AppColors.grey,
                  //   ),
                  // ),
                  // TextField(
                  //   controller: Provider.of<ProviderWatchlist>(context, listen: false).description,
                  //   cursorColor: AppColors.grey,
                  //   decoration: const InputDecoration(
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.grey),
                  //     ),
                  //     enabledBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.grey),
                  //     ),
                  //     hintText: "${AppStrings.enter} ${AppStrings.description}",
                  //     hintStyle: TextStyle(
                  //       fontSize: 10,
                  //       fontFamily: "roboto",
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ProviderWatchlist>(context, listen: false).createNewWatchList(context: context);
                    },
                    child: AppButton.button(
                      text: AppStrings.submit,
                      context: context,
                    ),
                  ),
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
