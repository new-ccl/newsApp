import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newsapp/page/entity.dart';
import 'package:newsapp/page/List_name_page/list_page.dart';
import 'package:newsapp/page/history_page.dart';
import 'love_page.dart';
import 'news_model.dart';


class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage>
    with SingleTickerProviderStateMixin {
  late final NewsTypeModel _model = NewsTypeModel();
  late final TabController _controller =
  TabController(vsync: this, length: _model.data!.data!.length);
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Entity?>(
        future: _model.getData(),
        builder: (BuildContext context, AsyncSnapshot<Entity?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: const [buildPopmenu()],
                backgroundColor: const Color(0xFF5E35B1),
                centerTitle: true,
                title: TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween(begin: 0.5, end: 1.0),
                  curve: Curves.bounceOut,
                  builder: (BuildContext context, value1, Widget? child) {
                    return TweenAnimationBuilder(
                      duration: Duration(seconds: 2),
                      tween: Tween(begin: 0.0, end: 6.28),
                      curve: Curves.bounceOut,
                      builder: ((BuildContext context, value2, Widget? child) {
                        return Opacity(
                          opacity: value1,
                          child: Transform.rotate(
                            angle: value2,
                            child: const Text(
                              'CUMT 新闻',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                bottom: TabBar(
                  isScrollable: true,
                  controller: _controller,
                  tabs: _model.data!.data!.map((value) {
                    return Tab(
                      text: value.name,
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                controller: _controller,
                children: _model.data!.data!
                    .map((value) => ListPage(type: value.type!))
                    .toList(),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF5E35B1),
                ),
                body: Center(
                    child: Image.asset("assets/image/642552b43cf1c.gif")));
          }
        });
  }
}
class buildPopmenu extends StatefulWidget {
  const buildPopmenu({Key? key}) : super(key: key);

  @override
  State<buildPopmenu> createState() => _buildPopmenuState();
}

class _buildPopmenuState extends State<buildPopmenu> {
  final List<String> list = ['历史记录','我的收藏'];

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
        switch(e){
          case '历史记录':Navigator.push(context, MaterialPageRoute(builder: ((BuildContext context) {
            return HisPage();
          })));break;
          case '我的收藏':Navigator.push(context, MaterialPageRoute(builder: ((BuildContext context) {
            return LovePage();
          })));break;
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