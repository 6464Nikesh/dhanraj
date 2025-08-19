import 'package:dhanraj/arguments/global_search_arg.dart';
import 'package:dhanraj/provider/provider_global_search.dart';
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalSearch extends StatefulWidget {
  final GlobalSearchArg globalSearchArg;

  const GlobalSearch({super.key, required this.globalSearchArg});

  @override
  State<GlobalSearch> createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.globalSearch),
      body: SafeArea(
        child: Consumer<ProviderGlobalSearch>(
          builder: (context, pds, child) {
            return PopScope(
              canPop: true,
              onPopInvokedWithResult: (didPop, result) {
                pds.clear();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              controller: pds.searchController,
                              style: Theme.of(context).textTheme.labelLarge,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (pds.fatching == false) {
                                    pds.fetchSymbols(context: context, search: value);
                                  }
                                } else {}
                              },
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
                          const Text(
                            "5/100",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "roboto",
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: pds.symbolsList.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    pds.symbolsList.length,
                                    (index) {
                                      var data = pds.symbolsList[index];
                                      return Column(
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
                                                          "${data.name ?? ""} ${pds.removeTrailingZeros(data.strike ?? "")}",
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
                                                              "${data.instrumentType}",
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
                                                              "${data.segment}",
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
                                                        (data.expiry != null)
                                                            ? Text(
                                                                Miscellaneous.dateConverterToDDMMMYYYY(data.expiry ?? ""),
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
                                              Consumer<ProviderWatchlist>(
                                                builder: (context, pw, child) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (10 > (pw.items?.length ?? 0)) {
                                                        await pds
                                                            .addSymbolsInWatchList(
                                                          watchlistId: widget.globalSearchArg.watchListId,
                                                          s: data,
                                                          context: context,
                                                        )
                                                            .then(
                                                          (value) {
                                                            Provider.of<ProviderWatchlist>(context, listen: false).getSymbolsList(context: context);
                                                          },
                                                        );
                                                        pds.setSelectedSymbols(index: index, val: true);
                                                      } else {
                                                        AppWidget().snackBar(context, AppStrings.youExceedLimit, Colors.redAccent, Colors.white);
                                                      }
                                                    },
                                                    child: (data.isSelected ?? false)
                                                        ? Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.green),
                                                            child: const Icon(
                                                              Icons.done,
                                                              color: Colors.white,
                                                              size: 20,
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.grey),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          (pds.symbolsList.length - 1 == index)
                                              ? Container()
                                              : const Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                  child: Divider(),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            : AppWidget.noDataFound(context),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
