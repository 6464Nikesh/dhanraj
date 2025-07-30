import 'package:dhanraj/pages/dailogs/confirmation_dialog.dart';
import 'package:dhanraj/provider/provider_settings.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_dashboard.dart';

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
            child:  Center(
              child: Text(
                Provider.of<ProviderDashboard>(context, listen: false).customerInitial ?? "",
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
        title: const Text(
          AppStrings.settings,
          style: TextStyle(
            fontFamily: "roboto",
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProviderSettings>(builder: (context, ps, child) {
        return Padding(
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
                      onTap: () {
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
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationDialog(
                            title: 'Log-out',
                            subtitle: "Are you sure you want to log-out.",
                            onTap: () {
                              ps.logOut(context);
                              return null;
                            },
                          );
                        },
                      );
                    },
                    child: AppButton.colorButton(
                      text: AppStrings.logout,
                      context: context,
                      color: AppColors.red,
                      textColor: Colors.white,
                      isActive: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
