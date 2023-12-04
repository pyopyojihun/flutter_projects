//Widget 모두 불변의 법칙을 가지고 있지만 변경이 필요하다면
//기존 위젯을 삭제해버리고 완전새로운 위젯으로 대체한다.
//statelessWidget 라이프 사이클
//Constructor로 생성되고 생성되자마자 build 함수가 실행됨.
//이전 Container 예제와 마찬가지로 변경이 필요하다면 새로운 위젯을 만듬
//하나의 StatelessWidget은 라이프 사이클동안 딱 한번만 build함수 실행

//but statefulWidget 라이프 사이클
//불변의 법칙은 따라야 하므로 state 를이용하여 구성
//Constructor 에서  createState를 통해 State 생성
// 가장 많이 사용되는 라이프 사이클은
//setstate->dirty->build->clean->setstate
//식으로 이동하는 라이프사이클이 가장 많이 사용됨

import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_study/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Root(),
  ));
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  Color color = Colors.blue;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: show
                      ? HomeScreen(
                          color: color,
                        )
                      : Container(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        color = color == Colors.red ? Colors.blue : Colors.red;
                      });
                    },
                    child: Text(
                      '색깔 변경하기',
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    child: Text(
                      !show ? '위젯 생성하기' : '위젯 삭제하기',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
