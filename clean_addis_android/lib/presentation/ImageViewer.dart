import 'package:flutter/material.dart';

class ImageViewPage
 extends StatelessWidget {
  const ImageViewPage
  ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
       body: new Image.network(
        "https://cdn.pixabay.com/photo/2017/02/21/21/13/unicorn-2087450_1280.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}