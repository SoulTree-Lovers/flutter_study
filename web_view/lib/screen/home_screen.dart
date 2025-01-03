import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUri = Uri.parse('https://www.google.com');

class HomeScreen extends StatelessWidget {
  WebViewController webViewController = WebViewController()
  ..loadRequest(homeUri); // ..을 입력하면 원래 인스턴스(WebViewController)를 그대로 리턴한다.

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
