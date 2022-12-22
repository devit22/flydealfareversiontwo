import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResultScreen extends StatefulWidget {
  final String? url;
  const ResultScreen({Key? key, this.url}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    super.initState();
    Future.delayed(Duration(seconds: 15), (){
      _controller.evaluateJavascript("document.getElementsByClassName('click-to-call')[0].style.display='none'");
      // print("this is printing after 10 seconds");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.iconColror,
          ),
        ),
        title: const Text(
          'Result Screen',
          style: TextStyle(color: ColorConstants.iconColror),
        ),
      ),
      body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          }),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to Starting Screen'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: ColorConstants.iconColror,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes',
                        style: TextStyle(
                          color: ColorConstants.iconColror,
                        )),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}
