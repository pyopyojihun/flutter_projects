import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    final timer = this.timer;
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  } //생명주기의 마지막

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark); //시간이나배터리등등이 다크로 바뀜
    return Scaffold(
        body: PageView(
      controller: controller,
      children: [1, 2, 3, 4, 5]
          .map((e) => Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ))
          .toList(),
      // children: [
      //   Image.asset(
      //     'asset/img/image_1.jpeg',
      //     fit: BoxFit.cover,
      //   ),
      //   Image.asset('asset/img/image_2.jpeg',fit: BoxFit.cover,),
      //   Image.asset('asset/img/image_3.jpeg',fit: BoxFit.cover,),
      //   Image.asset('asset/img/image_4.jpeg',fit: BoxFit.cover,),
      //   Image.asset('asset/img/image_5.jpeg',fit: BoxFit.cover,),
    ));
  }
}
