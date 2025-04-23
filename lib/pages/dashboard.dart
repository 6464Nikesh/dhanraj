import 'package:dhanraj/provider/provider_dashboard.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderDashboard>(builder: (context, pd, child) {
      return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 4,
            onTap: (val) {
              pd.changePages(val: val);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: AppColors.grey,
            selectedItemColor: AppColors.darkBlue,
            showUnselectedLabels: true,
            currentIndex: pd.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: AppStrings.watchlist),
              BottomNavigationBarItem(icon: Icon(Icons.area_chart), label: AppStrings.position),
              BottomNavigationBarItem(icon: Icon(Icons.watch_later), label: AppStrings.history),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppStrings.settings)
            ],
          ),
          body: Container(
            child: pd.pages[pd.currentIndex],
          ),
        ),
      );
    });
  }
}
