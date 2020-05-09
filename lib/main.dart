import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      title: 'Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = 'https://acupuncturesociety.org.uk/app/';
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool showLoading = false;
  void updateLoading(bool ls) {
    this.setState(() {
      showLoading = ls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: url,
              onPageStarted: (d) {
                updateLoading(true);
              },
              onPageFinished: (data) {
                updateLoading(false);
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              gestureNavigationEnabled: true,
            ),
            (showLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(),
          ],
        ),
      ),
    );
  }
}
