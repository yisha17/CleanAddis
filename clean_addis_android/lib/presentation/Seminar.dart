
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeminarPage extends StatefulWidget {
  const SeminarPage({ Key? key }) : super(key: key);

  @override
  State<SeminarPage> createState() => _SeminarPageState();
}

class _SeminarPageState extends State<SeminarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
          width: double.infinity,
          // height: 600,
          // the most important part of this example
          child: WebView(
            initialUrl: 'https://flutter.dev/',
            // Enable Javascript on WebView
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
