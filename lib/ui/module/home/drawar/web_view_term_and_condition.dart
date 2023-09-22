import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../services/navigator.dart';
import '../../../commonwidget/banner_image_carousel.dart';

class TermAndConditionWebView extends AppPageWithAppBar {
  static String routeName = "/termAndConditionWebView";
  final appPreferences = Get.find<AppPreferences>();

  static Future<bool?> start<bool>(String title, String webviewUrl) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title, arguments: {'webviewUrl': webviewUrl});
  }

  final Set gestureRecognizers = {Set<Factory<OneSequenceGestureRecognizer>>};

  @override
  Widget get body {
    String url = arguments["webviewUrl"];
    return SafeArea(
        child:WebView(
              gestureRecognizers: Set()
                ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
              initialUrl: url,
              onWebResourceError: (WebResourceError error) {
                //Common.showToast(error.description);
                print(error.description);
                //loadUrl("http://connectivitycheck.gstatic.com/generate_204");
              },
              allowsInlineMediaPlayback: true,
              javascriptMode: JavascriptMode.unrestricted,
            ),



    );
  }

  Widget get banner {
    List<String> banner = appPreferences.banner;
    List<BannerData> bannerData = <BannerData>[];
    for (String item in banner) {
      bannerData.add(BannerData(bannerId: 1, img: item));
    }
    return BannerCarousel(bannerList: bannerData);
  }
}
