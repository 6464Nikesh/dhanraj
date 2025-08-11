import 'package:dhanraj/pages/dailogs/confirmation_dialog.dart';
import 'package:dhanraj/provider/provider_settings.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/method_channel/app_share.dart';
import '../settings/change_password.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderSettings>(context, listen: false).getPrefData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProviderSettings>(
          builder: (context, ps, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            (ps.loginModel?.result?.user?.userName?.isNotEmpty ?? false)
                                ? Image.asset(
                                    ps.getCompanyLogo(userName: ps.loginModel?.result?.user?.userName ?? ""),
                                    scale: 8,
                                  )
                                : Container(),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${ps.loginModel?.result?.user?.firstName} ${ps.loginModel?.result?.user?.lastName}",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  ps.getCompanyName(userName: ps.loginModel?.result?.user?.userName ?? "").toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: AppColors.grey,
                                      ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ps.loginModel?.result?.user?.userName ?? "",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      " - ${ps.getServerName(userName: ps.loginModel?.result?.user?.userName ?? "")} Server",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: const ChangePassword(),
                                ),
                              );
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
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              ps.navigate(context: context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.rate_review_outlined,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppStrings.rateUs,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "roboto",
                                        color: AppColors.navyBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              AppShare().shareFile();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppStrings.shareUs,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "roboto",
                                        color: AppColors.navyBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
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
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Image.asset(
                      AppAssets.fullLogo,
                      scale: 6,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Thank you, you are using Dhanraj Trading as your trading platform.",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
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
