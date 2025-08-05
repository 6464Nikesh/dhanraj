import 'package:dhanraj/provider/provider_dashboard.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/web_socket_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderDashboard>(context, listen: false).getPrefData();

        Future.microtask(() {
          final webSocketService = Provider.of<WebSocketService>(context, listen: false);
          webSocketService.connect(context: context); // Open WebSocket connection here
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderDashboard>(builder: (context, pd, child) {
      return PopScope(
        canPop: false,
        child: Scaffold(
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
                child: Center(
                  child: Consumer<ProviderDashboard>(builder: (context, pd, child) {
                    return Text(
                      pd.customerInitial ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                ),
              ),
            ),
            title: Consumer<WebSocketService>(builder: (context, wss, _) {
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${pd.loginModel?.result?.user?.firstName ?? " "}",
                          style: Theme.of(context).textTheme.titleSmall
                        ), Text(
                          pd.loginModel?.result?.user?.userName ?? "",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Text(
                          "Nifty 50",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(wss.latestData[256265]?["last_price"].toString() ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.red)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Text(
                          "SENSEX",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(wss.latestData[265]?["last_price"].toString() ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.green)),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 4,
            onTap: (val) {
              pd.changePages(val: val, context: context);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: AppColors.grey.withOpacity(0.3),
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
