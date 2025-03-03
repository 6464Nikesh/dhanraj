import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProviderWatchlist>(builder: (context, pw, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Center(
                          child: Text(
                            "S",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "roboto",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Expanded(
                      child: Text(
                        AppStrings.watchlist,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "roboto",
                          color: AppColors.navyBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_downward_outlined)
                  ],
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade100)),
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
                            Navigator.pushNamed(context, AppRoutes.globalSearch);
                          },
                          style: Theme.of(context).textTheme.labelLarge,
                          keyboardType: TextInputType.name,
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.grey,
                        height: 20,
                        width: 1,
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
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: pw.tabIndex == 0 ? AppColors.navyBlue : Colors.white,
                                ),
                              ),
                            ),
                            child: const Text(
                              "Bank Nifty",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "roboto",
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: pw.tabIndex == 1 ? AppColors.navyBlue : Colors.white,
                                ),
                              ),
                            ),
                            child: const Text(
                              "Nifty",
                              style: TextStyle(fontWeight: FontWeight.w500, fontFamily: "roboto", fontSize: 12, color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.navyBlue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: AppColors.navyBlue,
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (val) {
                      pw.changePage(val);
                    },
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return pw.watchlistTab[pw.tabIndex];
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
