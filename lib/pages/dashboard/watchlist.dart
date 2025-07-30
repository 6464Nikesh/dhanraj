import 'package:dhanraj/arguments/global_search_arg.dart';
import 'package:dhanraj/pages/bottom_sheet/create_new_watchlist_bottom_sheet.dart';
import 'package:dhanraj/pages/watchlist/trade_bottom_sheet.dart';
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_delete_dialogs.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_dashboard.dart';
import '../../provider/web_socket_service.dart';
import '../../utils/miscellaneous.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderWatchlist>(context, listen: false).getWatchList(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkBlue,
            ),
            child:  Center(
              child: Consumer<ProviderDashboard>(
                  builder: (context,pd,child) {
                    return Text(
                      pd.customerInitial ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
              ),
            ),
          ),
        ),
        title: const Text(
          AppStrings.watchlist,
          style: TextStyle(
            fontFamily: "roboto",
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer2<ProviderWatchlist, WebSocketService>(
        builder: (context, pw, ws, child) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            GlobalSearchArg arg = GlobalSearchArg(
                              watchListId: pw.selectedWatchList?.watchlistId ?? "",
                            );
                            Navigator.pushNamed(context, AppRoutes.globalSearch, arguments: arg).then(
                              (value) {
                                pw.getSymbolsList(context: context);
                              },
                            );
                          },
                          style: Theme.of(context).textTheme.labelLarge,
                          keyboardType: TextInputType.name,
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: AppStrings.searchAndAdd,
                            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.tune,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            pw.watchLists?.length ?? 0,
                            (index) {
                              var data = pw.watchLists?[index];
                              return GestureDetector(
                                onTap: () {
                                  pw.selSelectedWatchList(selectedWatchList: data, context: context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: pw.selectedWatchList?.watchlistId == data?.watchlistId ? AppColors.navyBlue : Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        data?.watchlistName ?? "",
                                        style: TextStyle(
                                          fontWeight: pw.selectedWatchList?.watchlistId == data?.watchlistId ? FontWeight.bold : FontWeight.w400,
                                          fontFamily: "roboto",
                                          fontSize: 12,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
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
                              child: const CreateNewWatchlistBottomSheet(),
                            );
                          },
                        ).then(
                          (value) {
                            if (value != null) {
                              pw.getWatchList(context: context);
                            }
                          },
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        color: AppColors.navyBlue,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: (pw.items?.isNotEmpty ?? false)
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: List.generate(
                              pw.items?.length ?? 0,
                              (index) {
                                var data = pw.items?[index];
                                int? instrumentToken = int.tryParse(data?.symbol?.instrumentToken ?? '');
                                var socketData = ws.latestData[SubscriptionType.watchlist]![instrumentToken];

                                String lastPrice = '00.00';
                                String changePercent = '00.00';
                                num change = 0;

                                Color priceColor = Colors.black;

                                if (socketData != null && socketData['instrument_token'] == instrumentToken) {
                                  num price = socketData['last_price'] ?? 0;
                                  num prevClose = socketData['ohlc']['close'] ?? 0;

                                  change = price - prevClose;
                                  num percent = (prevClose > 0) ? ((change / prevClose) * 100) : 0;

                                  lastPrice = price.toString();
                                  changePercent = '${percent.toStringAsFixed(2)}%';

                                  if (change > 0) {
                                    priceColor = Colors.green;
                                  } else if (change < 0) {
                                    priceColor = Colors.red;
                                  } else {
                                    priceColor = Colors.grey;
                                  }
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Dismissible(
                                    key: Key(data?.watchlistItemId ?? ""),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AppDeleteDialogs(
                                            onTap: () {
                                              pw.deleteWatchListItem(
                                                context: context,
                                                id: data?.watchlistItemId ?? "",
                                              );
                                            },
                                          );
                                        },
                                      ).then(
                                        (value) {
                                          if (value == true) {
                                            pw.getSymbolsList(context: context);
                                          }
                                        },
                                      );
                                    },
                                    background: Container(
                                      color: AppColors.red,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.delete_outline, size: 30, color: Colors.white),
                                        ],
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                          ),
                                          builder: (context) => TradeBottomSheet(
                                            items: data,
                                            lastPrice: lastPrice,
                                            differentPercentage: changePercent,
                                            color: priceColor,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: const Offset(
                                                2.0,
                                                2.0,
                                              ),
                                              blurRadius: 3.0,
                                              spreadRadius: 1.0,
                                            ), //BoxShadow
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                          color: Colors.white,
                                          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${data?.symbol?.name ?? ""}${pw.removeTrailingZeros(data?.symbol?.strike ?? "")}",
                                                              style: const TextStyle(
                                                                fontFamily: "roboto",
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(4),
                                                                child: Text(
                                                                  "${data?.symbol?.instrumentType}",
                                                                  style: const TextStyle(
                                                                    fontFamily: "roboto",
                                                                    fontSize: 8,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.grey.withOpacity(0.1)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                                child: Text(
                                                                  "${data?.symbol?.segment}",
                                                                  style: const TextStyle(
                                                                    fontFamily: "roboto",
                                                                    fontSize: 8,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            (data?.symbol?.expiry != null)
                                                                ? Text(
                                                                    Miscellaneous.dateConverterToDDMMMYYYY(data?.symbol?.expiry ?? ""),
                                                                    style: const TextStyle(
                                                                      fontFamily: "roboto",
                                                                      fontSize: 8,
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ],
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
                                                          Text(
                                                            lastPrice,
                                                            style: TextStyle(
                                                              fontFamily: "roboto",
                                                              fontSize: 14,
                                                              color: priceColor,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                change.toStringAsFixed(2),
                                                                style: TextStyle(
                                                                  fontFamily: "roboto",
                                                                  fontSize: 10,
                                                                  color: priceColor,
                                                                ),
                                                              ),
                                                              Text(
                                                                " ($changePercent)",
                                                                style: TextStyle(
                                                                  fontFamily: "roboto",
                                                                  fontSize: 10,
                                                                  color: priceColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
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
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.emptyBox,
                              scale: 10,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    GlobalSearchArg arg = GlobalSearchArg(
                                      watchListId: pw.selectedWatchList?.watchlistId ?? "",
                                    );
                                    Navigator.pushNamed(context, AppRoutes.globalSearch, arguments: arg).then(
                                      (value) {
                                        pw.getSymbolsList(context: context);
                                      },
                                    );
                                  },
                                  child: AppButton.colorButton(
                                    text: AppStrings.addSymbols,
                                    context: context,
                                    color: AppColors.navyBlue,
                                    textColor: Colors.white,
                                    isActive: true,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
