import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(
            name: "ios_channel", binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "shareFile" {
                if let link = call.arguments as? String {
                    self.shareDocumentLink(link)
                    result("Sharing File")
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)

    }

    private func shareDocumentLink(_ link: String) {
        DispatchQueue.main.async {
            let textToShare = [link]
            let activityVC = UIActivityViewController(
                activityItems: textToShare, applicationActivities: nil)

            activityVC.modalPresentationStyle = .popover

            if let rootViewController = self.window?.rootViewController {
                if let popoverPresentationController = activityVC.popoverPresentationController {
                    popoverPresentationController.sourceView = rootViewController.view
                    popoverPresentationController.sourceRect = CGRect(
                        x: rootViewController.view.bounds.midX,
                        y: rootViewController.view.bounds.midY, width: 0, height: 0)
                    popoverPresentationController.permittedArrowDirections = []

                }
                rootViewController.present(activityVC, animated: true) {
                    print("Share dialog presented")
                }
            } else {
                print("Root view controller not found")
            }

        }

    }
}
