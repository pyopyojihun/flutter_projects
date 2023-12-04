import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteThree extends StatelessWidget {
  const RouteThree({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;

    return MainLayOut(title: 'Route three', children: [
      Text(
        'argument: ${argument}',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'))
    ]);
  }
}
