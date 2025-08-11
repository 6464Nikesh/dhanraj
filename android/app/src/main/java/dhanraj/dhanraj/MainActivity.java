package dhanraj.trading;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "android_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("shareFile")) {
                String link = call.arguments();
                shareDocumentLink(link);
                result.success(null);
            } else {
                result.notImplemented();
            }
        });
    }

    private void shareDocumentLink(String link) {
        Intent intent = new Intent();
        intent.setAction(Intent.ACTION_SEND);
        intent.putExtra(Intent.EXTRA_TEXT, link);
        intent.setType("text/plain");
        Intent shareIntent = Intent.createChooser(intent, "Share");
        startActivity(shareIntent);
    }
}
