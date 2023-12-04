import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TestWidget(label: 'test1'), //const를 쓰면 다른점 앱이실행하는 동안한번만
            //그려놓으면 다음에 이 빌드가 실행이 됐을 때 이미그려놨던  위젯을 기억하고 그대로 사용가능
            //다시 실행하지 않아도 된다는 뜻 따라서 효율이 좋음 다시 build 안됨
            TestWidget(label: 'test2'),
            ElevatedButton(
                //여기에는 const 안붙음 왜? 눌리는 순간에만 알 수있기 때문에 못씀
                onPressed: () {
                  setState(() {}); //목적 ?? life cycle 다시 생성 다시 build
                },
                child: Text('build!'))
            //but text에는 const 기재 가능
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label build 실행!');
    return Container(
      child: Text(label),
    );
  }
}
