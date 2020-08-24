import 'package:Kide/config/Viewport.dart';
import 'package:Kide/pages/ForYou/widgets/MustSeeWidget.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: WebView(
        initialUrl: "https://kiitportal.kiituniversity.net/irj/portal/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
