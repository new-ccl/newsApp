import 'package:flutter/material.dart';

import 'SecondPage.dart';
import 'ThreePage.dart';
import 'navigator_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final List<Widget> list = const [NavigatorPage(), SleepPage(), PeoplePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '主页',
              backgroundColor: Color(0xFF5E35B1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: '小憩',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: '个性化',
              backgroundColor: Colors.blue),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF5E35B1),
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
