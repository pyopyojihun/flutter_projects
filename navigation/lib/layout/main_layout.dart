import 'package:flutter/material.dart';

class MainLayOut extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const MainLayOut({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ));
  }
}
