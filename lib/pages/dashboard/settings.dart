import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            child: const Center(
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
        title: Text(
          AppStrings.settings,
          style: const TextStyle(
            fontFamily: "roboto",
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        child: Column(
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.profile,
                            scale: 3,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Text(
                              AppStrings.profile,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "roboto",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.funds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.funds,
                            scale: 3,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Text(
                              AppStrings.funds,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "roboto",
                                color: AppColors.navyBlue,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.tradingTerms);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.trading,
                            scale: 3,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Text(
                              AppStrings.tradingTerms,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "roboto",
                                color: AppColors.navyBlue,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.lock,
                            scale: 3,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Text(
                              AppStrings.changePassword,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "roboto",
                                color: AppColors.navyBlue,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
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
