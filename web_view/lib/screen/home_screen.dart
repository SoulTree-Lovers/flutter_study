import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUri = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted) // 안드로이드는 기본적으로 JavaScript가 비활성화되어 있고, iOS는 기본적으로 활성화되어 있다.
    ..loadRequest(homeUri); // ..을 입력하면 원래 인스턴스(WebViewController)를 그대로 리턴한다.

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              webViewController.loadRequest(homeUri);
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
