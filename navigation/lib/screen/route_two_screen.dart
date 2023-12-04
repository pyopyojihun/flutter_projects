import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayOut(
      title: 'Route Two',
      children: [
        Text(
          'arguments: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text('Push Named'),
        ),
        //또다른 push 방법
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              '/three',
            );
            //Navigator.of(context).pushReplacement(
            //  MaterialPageRoute(builder: (_) => RouteThree()));
          },
          child: Text('Push Replacement'),
          //pushreplacement를 사용하여 route three로 갔다가 pop할때 routeone으로 가짐
          //[HomeScreen(),RouteOne(),RouteTwo(),Route(three)]
          //[Homescreen(),RouteOne(),RouteThree()]=>Routetwo를 지워버려서 one으로감
          //Pushreplacementnamed도 동일
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => RouteThree(),
              ),
              (route) => route.settings.name == '/',
            );
            //navigation안에있는 모든 route 에 false로 하면 다 삭제
            //route.settings.name =='/' 로하면 pop을 했을때 homescreen으로 감
          },
          child: Text('Push And Remove Until'),
        )
      ],
    );
  }
}
