import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: widget.title,
        isProfileView: false,
        bgColor: AppColors.zircon,
        leadingPopAll: false,

        actionOnTap: () {
          return;
        },
      ),
      body: Center(
        child: InAppWebView(
          implementation: WebViewImplementation.NATIVE,
          initialUrlRequest: URLRequest(
            url: Uri.parse(
              widget.url.toString(),
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadStart: (controller, url) async {
            debugPrint("here is the url $url");
          },
        ),
      ),
    );
  }
}
