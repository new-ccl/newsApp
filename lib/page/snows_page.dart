import 'dart:math';

import 'package:flutter/material.dart';

int count=100;
class SnowsPage extends StatefulWidget {
  const SnowsPage({super.key});


  @override
  State<SnowsPage> createState() => _SnowsPageState();
}

class _SnowsPageState extends State<SnowsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Snowflake> _snowflakes = List.generate(count, (index) => Snowflake());

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    List<Snowflake> _snowflakes = List.generate(count, (index) => Snowflake());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("冰雪世界",style: TextStyle(
            fontSize:18,
          ),),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.ac_unit)),
            buildPopmenu()
          ],
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              _snowflakes.forEach((element) {
                element.fall();
              });
              return Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.blue,
                child: CustomPaint(
                  painter: MyPaint(_snowflakes),
                ),
              );
            },
          ),
        ));
  }
}

class MyPaint extends CustomPainter {
  final List<Snowflake> snowflakes;

  MyPaint(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawCircle(size.center(const Offset(0, 110)), 60.0, whitePaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(const Offset(0, 280)), width: 200, height: 250),
        whitePaint);

    for (var element in snowflakes) {
      canvas.drawCircle(
          Offset(element.x, element.y), element.radius, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = 20;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  fall() {
    y += velocity;
    if (y > 800) {
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
      y = 0;
    }
  }
}

class buildPopmenu extends StatefulWidget {
  const buildPopmenu({Key? key}) : super(key: key);

  @override
  State<buildPopmenu> createState() => _buildPopmenuState();
}

class _buildPopmenuState extends State<buildPopmenu> {
  final List<String> list = ['小型雪', '大型雪', '究极暴雪'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => _buildpopmenu(),
      offset: const Offset(0, 50),
      color: const Color(0xffF4FFFA),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(5))),
      onSelected: (e) {
        switch (e) {
          case '小型雪':
            count = 100;
            break;
          case '大型雪':
            count = 1000;
            break;
          case '究极暴雪':
            count = 10000;
            break;
        }
      },
    );
  }

  List<PopupMenuItem<String>> _buildpopmenu() {
    return list
        .map((e) => PopupMenuItem<String>(
      value: e,
      child: Wrap(
        spacing: 10,
        children: [
          Text(e),
        ],
      ),
    ))
        .toList();
  }
}