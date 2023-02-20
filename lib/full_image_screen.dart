import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  var urlToShow;
  FullImageScreen({Key? key, required this.urlToShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'full',
      child: Container(child: Image.network(urlToShow)),
    );
  }
}
