import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwallpapers/utils/ads.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

enum SetWallpaperAs { home, lock, both }

const _setAs = {
  SetWallpaperAs.home: WallpaperManagerFlutter.HOME_SCREEN,
  SetWallpaperAs.lock: WallpaperManagerFlutter.LOCK_SCREEN,
  SetWallpaperAs.both: WallpaperManagerFlutter.BOTH_SCREENS,
};

Future<void> setWallpaper(
    {required BuildContext context, required String url}) async {
  late RewardedAd rewardedAd;

  RewardedAd.load(
      adUnitId: MyAds.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        rewardedAd = ad;
      }, onAdFailedToLoad: (error) {
        print("Failed to load interstial ad Ad${error.message}");
      }));

  var actionSheet = CupertinoActionSheet(
    title: const Text(
      "Set as",
      style: TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
      ),
    ),
    actions: [
      CupertinoActionSheetAction(
          onPressed: () {
            rewardedAd.show(onUserEarnedReward: (ad, rPoint) {
              print("Wallpaper is set and rewarded ${rPoint.amount}");
            });
            Navigator.of(context).pop(SetWallpaperAs.home);
          },
          child: const Text(
            "Home Screen",
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          )),
      CupertinoActionSheetAction(
          onPressed: () {
            rewardedAd.show(onUserEarnedReward: (ad, rPoint) {
              print("Wallpaper is set and rewarded ${rPoint.amount}");
            });
            Navigator.of(context).pop(SetWallpaperAs.lock);
          },
          child: const Text(
            "Lock Screen",
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          )),
      CupertinoActionSheetAction(
          onPressed: () {
            rewardedAd.show(onUserEarnedReward: (ad, rPoint) {
              print("Wallpaper is set and rewarded ${rPoint.amount}");
            });
            Navigator.of(context).pop(SetWallpaperAs.both);
          },
          child: const Text("Both Screen"))
    ],
  );
  SetWallpaperAs option = await showCupertinoModalPopup(
      context: context, builder: (context) => actionSheet);
  if (option != null) {
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    if (cachedImage != null) {
      WallpaperManagerFlutter()
          .setwallpaperfromFile(cachedImage, _setAs[option]);
    }
  }
}
