import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UpdateChecker {
  static Future<void> checkForUpdate(BuildContext context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval:  Duration.zero,
    ));

    await remoteConfig.fetchAndActivate();

    String minVersion = remoteConfig.getString('min_version');
    String latestVersion = remoteConfig.getString('latest_version');
    String updateUrlAndroid = remoteConfig.getString('update_url_android');
    String updateUrlIos = remoteConfig.getString('update_url_ios');


    print(minVersion);
    print(latestVersion);
    print(updateUrlAndroid);
    print(updateUrlIos);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    if (_isVersionLower(currentVersion, minVersion)) {
      // Force update
      _showCupertinoDialog(context, updateUrlAndroid, updateUrlIos, force: true);
    } else if (_isVersionLower(currentVersion, latestVersion)) {
      // Minor update
      _showCupertinoDialog(context, updateUrlAndroid, updateUrlIos, force: false);
    }
  }

  static bool _isVersionLower(String current, String target) {

    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> targetParts = target.split('.').map(int.parse).toList();



    for (int i = 0; i < targetParts.length; i++) {
      if (currentParts[i] < targetParts[i]) return true;
      if (currentParts[i] > targetParts[i]) return false;
    }
    return false;
  }

  static void _showCupertinoDialog(
    BuildContext context,
    String androidUrl,
    String iosUrl, {
    required bool force,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: !force,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Update Available"),
          content: Text(force ? "You must update to continue using the app." : "A newer version is available. Please update for the best experience."),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                final url = Theme.of(context).platform == TargetPlatform.iOS ? iosUrl : androidUrl;
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                }
              },
              child: const Text("Update"),
            ),
            if (!force)
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text("Later"),
              ),
          ],
        );
      },
    );
  }
}
