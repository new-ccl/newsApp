import 'dart:math';
import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  bool flag = true;
  List list = [
    "跟着圈圈深呼吸",
    "继续深~呼吸，放空大脑",
    "肩膀完全放松~",
    "手臂也完全放松~",
    "放松大腿，小腿",
    '忘记烦恼，身体现在很轻松',
    "闭上眼睛，感受宁静的几分钟"
  ];
  double decial = 0.0;
  int num=Random().nextInt(9)+1;


  @override
  void initState() {
    _scaleController = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this,
        upperBound: 1.0,
        lowerBound: 0.3);
    _fadeController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 70),
        upperBound: 6.9999,
        lowerBound: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('休息室'),
        centerTitle: true,
        backgroundColor: const Color(0xFF5E35B1),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image1/$num.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      // padding: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _fadeController,
            builder: (BuildContext context, Widget? child) {
              int whole = _fadeController.value.toInt();
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                child: Text(
                  list[whole],
                  key: UniqueKey(),
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10,),
          AnimatedBuilder(
            animation: _scaleController,
            builder: (BuildContext context, Widget? child) {
              return ScaleTransition(
                scale: _scaleController,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                ),
              );
            },
          ),
        ],
      ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (flag) {
            _scaleController.repeat(reverse: true);
            _fadeController.repeat();
          } else {
            _scaleController.reset();
            _fadeController.reset();
          }
          flag = !flag;
        },
        backgroundColor: const Color(0xFF5E35B1),
        child: const Text('开始'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}