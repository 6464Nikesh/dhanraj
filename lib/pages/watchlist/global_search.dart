import 'package:dhanraj/arguments/global_search_arg.dart';
import 'package:dhanraj/provider/provider_global_search.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderGlobalSearch>(context, listen: false).getSymbols(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.globalSearch),
      body: SafeArea(
        child: Consumer<ProviderGlobalSearch>(
          builder: (context, pds, child) {
            return Padding(
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
                                pds.filter(value);
                              } else {
                                pds.filterClear();
                              }
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
                  pds.searchController.text.isEmpty
                      ? Expanded(
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
                                                            data.tradingsymbol ?? "",
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
                                                      Text(
                                                        "${data.exchange} | ${data.segment}",
                                                        style: const TextStyle(
                                                          fontFamily: "roboto",
                                                          fontSize: 8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    pds.addSymbolsInWatchList(watchlistId: widget.globalSearchArg.watchListId, s: data, context: context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.grey),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
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
                                  ))
                                : AppWidget.noDataFound(context),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: pds.filteredSymbolsList.isNotEmpty
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        pds.filteredSymbolsList.length,
                                        (index) {
                                          var data = pds.filteredSymbolsList[index];
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
                                                              data.tradingsymbol ?? "",
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
                                                        Text(
                                                          "${data.exchange} | ${data.segment}",
                                                          style: const TextStyle(
                                                            fontFamily: "roboto",
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      pds.addSymbolsInWatchList(watchlistId: widget.globalSearchArg.watchListId, s: data, context: context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.grey),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              (pds.filteredSymbolsList.length - 1 == index)
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
            );
          },
        ),
      ),
    );
  }
}
