//주요기술 webview and Appbar pub.dev(외부 패키지사용법 )
//블로그 웹앱 섹션 6
import 'package:flutter_study_1/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  //Flutter 프레임워크가
  //앱을 실행할 준비가 될떄까지 기다린다.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
