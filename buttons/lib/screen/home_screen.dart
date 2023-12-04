import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('버튼')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Buttonstyle')),
            ElevatedButton(
              //3D로 조금 튀어나온형태
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                //메인 color
                onPrimary: Colors.black,
                //글자 및 애니메이션 색
                shadowColor: Colors.green,
                elevation: 10.0, // 입체감을 줄 수 있는 형태의 파라미터 3D 입체감의 높이
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ), // 테두리 색 정할때 사용
              ),

              child: Text('ElevatedButton'),
            ),
            OutlinedButton(
              //테두리만있는 버튼
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.yellow,
                elevation: 10.0,
              ),
              child: Text('OutlinedButton'),
            ),
            TextButton(
                onPressed: () {}, //text만 있는버튼
                style: TextButton.styleFrom(
                  primary: Colors.brown,
                  backgroundColor: Colors.blue,
                ),
                child: Text('TextButton'))
          ],
        ),
      ),
    );
  }
}
