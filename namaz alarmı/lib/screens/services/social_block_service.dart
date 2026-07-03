import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';

class SocialBlockService {
  static const platform = MethodChannel('com.example.namaz_kontrol/block');

  static List<String> socialApps = [
    'com.instagram.android',
    'com.zhiliaoapp.musically', // TikTok
    'com.twitter.android',
    'com.facebook.katana',
    'com.google.android.youtube',
  ];

  static Future<void> blockSocialMedia() async {
    for (var package in socialApps) {
      try {
        if (await DeviceApps.isAppInstalled(package)) {
          // TODO: Gerçek bloklama için Accessibility Service gerekiyor
          print('$package engellendi');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> unblockSocialMedia() async {
    print('Sosyal medya uygulamaları açıldı');
    // Accessibility Service ile kilidi kaldırma
  }
}