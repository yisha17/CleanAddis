
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeminarPage extends StatefulWidget {
  
  final String link;
  SeminarPage({Key? key,required this.link}) : super(key: key);


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
            initialUrl: widget.link,
            // Enable Javascript on WebView
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
