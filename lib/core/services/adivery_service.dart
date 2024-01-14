import 'package:adivery/adivery.dart';
import 'package:contracts_bank/core/utils/const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InterstitialAds {
  static void _showPlacement(
      bool isLoaded, String placementId, void Function(String)? onClose) {
    if (isLoaded) {
      AdiveryPlugin.addListener(
        onInterstitialClosed: onClose,
      );
      AdiveryPlugin.show(placementId);
    } else {
      Fluttertoast.showToast(msg: 'هم اکنون تبلیغ  آماده نمایشی وجود ندارد!');
    }
  }

  static showInterstitial({void Function(String)? onClose}) {
    AdiveryPlugin.prepareInterstitialAd(adsPlacementID);

    AdiveryPlugin.isLoaded(adsPlacementID)
        .then((isLoaded) => _showPlacement(isLoaded!, adsPlacementID, onClose));
    // AdiveryPlugin.isLoaded(adsPlacementID).then((isLoaded) => print(isLoaded));
  }
}
