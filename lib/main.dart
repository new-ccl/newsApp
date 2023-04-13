import 'package:flutter/material.dart';
import 'package:newsapp/page/ThreePage.dart';
import 'package:newsapp/page/home_page.dart';
import 'package:provider/provider.dart';
import 'list_data.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppModel()),
      ChangeNotifierProvider(create: (_)=>NewsListProvider())
    ],
    child: Consumer<AppModel>(
      builder: (context,appmodel,_){
        return MaterialApp(
          theme: list[Provider.of<AppModel>(context).currentidex],
          darkTheme: ThemeData.dark(),
          home: const HomePage(),
        );
      },
    ),
  ),);
}
List<ThemeData> list=[
  ThemeData(
    scaffoldBackgroundColor:Colors.cyan,//主页面
    highlightColor: Colors.black,
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.cyan,
          dense: true,
          textColor: Colors.black
      )
  ),
  ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:Colors.white,//主页面
    highlightColor: Colors.black,
  ),
  ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:Colors.black,//主页面
    highlightColor: Colors.white,
    listTileTheme: const ListTileThemeData(
        tileColor: Colors.black,
        dense: true,
        textColor: Colors.white
    )
  ),
  ThemeData(
    scaffoldBackgroundColor:Colors.blue,//主页面
    highlightColor: Colors.white,
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.blue,
          dense: true,
          textColor: Colors.black
      )
  )
];




