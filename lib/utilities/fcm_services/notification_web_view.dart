import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class NotificationWebView extends StatefulWidget {
  final String? title;
  final String? url;

  const NotificationWebView({
    Key? key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  NotificationWebViewState createState() => NotificationWebViewState();
}

class NotificationWebViewState extends State<NotificationWebView> {
  bool isLoading = false;
  bool isBackNavigationAllowed = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          isProfileView: false,
          title: widget.title.toString(),
          bgColor: AppColors.zircon,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(
              widget.url.toString(),
            ),
          ),
          onWebViewCreated: (InAppWebViewController webViewController) {
            debugPrint("here is web_view created ");
          },
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadError: (controller, url, code, message) async {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
