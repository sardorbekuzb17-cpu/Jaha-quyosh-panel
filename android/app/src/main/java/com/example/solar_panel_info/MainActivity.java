package com.example.solar_panel_info;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.content.pm.PackageManager;
import android.content.pm.ApplicationInfo;
import android.widget.Toast;
import androidx.core.content.FileProvider;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "quyosh24/native";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                switch (call.method) {
                    case "getDeviceInfo":
                        Map<String, String> deviceInfo = getDeviceInfo();
                        result.success(deviceInfo);
                        break;
                        
                    case "openAppSettings":
                        openAppSettings();
                        result.success(true);
                        break;
                        
                    case "installApk":
                        String filePath = call.argument("filePath");
                        if (filePath != null) {
                            installApk(filePath);
                            result.success(true);
                        } else {
                            result.error("INVALID_ARGUMENT", "File path is null", null);
                        }
                        break;
                        
                    case "shareApp":
                        shareApp();
                        result.success(true);
                        break;
                        
                    case "showToast":
                        String message = call.argument("message");
                        if (message != null) {
                            showToast(message);
                            result.success(true);
                        } else {
                            result.error("INVALID_ARGUMENT", "Message is null", null);
                        }
                        break;
                        
                    default:
                        result.notImplemented();
                        break;
                }
            });
    }

    private Map<String, String> getDeviceInfo() {
        Map<String, String> deviceInfo = new HashMap<>();
        deviceInfo.put("model", android.os.Build.MODEL);
        deviceInfo.put("manufacturer", android.os.Build.MANUFACTURER);
        deviceInfo.put("version", android.os.Build.VERSION.RELEASE);
        deviceInfo.put("sdk", String.valueOf(android.os.Build.VERSION.SDK_INT));
        deviceInfo.put("brand", android.os.Build.BRAND);
        return deviceInfo;
    }

    private void openAppSettings() {
        try {
            Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
            Uri uri = Uri.fromParts("package", getPackageName(), null);
            intent.setData(uri);
            startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void installApk(String filePath) {
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            Uri uri = Uri.parse(filePath);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void shareApp() {
        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType("text/plain");
        shareIntent.putExtra(Intent.EXTRA_SUBJECT, "Quyosh24 - Quyosh Paneli Ilovasi");
        shareIntent.putExtra(Intent.EXTRA_TEXT, 
            "Quyosh panellari haqida to'liq ma'lumot olish uchun Quyosh24 ilovasini yuklab oling!\n\n" +
            "GitHub: https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel");
        startActivity(Intent.createChooser(shareIntent, "Ilovani ulashish"));
    }

    private void showToast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        showToast("Quyosh24 - JAHON GROUP");
    }
}