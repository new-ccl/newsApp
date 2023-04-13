import 'package:flutter/material.dart';
import 'package:newsapp/page/snows_page.dart';
import 'package:provider/provider.dart';

import 'SecondPage.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 260,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image1/10.jpg'),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/image1/11.jpg'),
                      ),
                    ),
                    height: 70,
                    width: 70,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Text(
                      "建造我们的世界",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          ExpansionTile(
            title: Text('个性化'),
            subtitle: Text('切换主题背景'),
            children: <Widget>[
              ListTile(
                title: Row(
                  children: [
                    colorBox(Colors.cyan,1),
                    const SizedBox(
                      width: 20,
                    ),
                    colorBox(Colors.white,2),
                    const SizedBox(
                      width: 20,
                    ),
                    colorBox(Colors.black,3),
                    const SizedBox(
                      width: 20,
                    ),
                    colorBox(Colors.blue,4)
                  ],
                ),
              ),
            ],
          ),
          // ExpansionTile(
          //   title: Text('个性化'),
          //   subtitle: Text('切换背景图片'),
          //   children: <Widget>[
          //     ListTile(
          //       title: Row(
          //         children: [
          //           numBox('1'),
          //           numBox('2'),
          //           numBox('3'),
          //           numBox('4'),
          //           numBox('5'),
          //           numBox('6'),
          //           numBox('7'),
          //           numBox('8'),
          //           numBox('9'),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return const SnowsPage();
              }));
            },
            child: Container(
              height: 65,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [BoxShadow(blurRadius: 1)]
              ),
              child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }

  InkWell colorBox(Color c,int index) {
    int _index=index ;
    return InkWell(
      onTap: () {
        final appModel = Provider.of<AppModel>(context, listen: false);
        appModel.switchColors(_index);
      },
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: c,
        ),
        child: const Icon(Icons.color_lens_outlined),
      ),
    );
  }
}
class AppModel with ChangeNotifier{
  int currentidex=1;
  switchColors(int c){
    switch (c){
      case 1: currentidex=0;break;
      case 2: currentidex=1;break;
      case 3: currentidex=2;break;
      case 4: currentidex=3;break;
    }
    notifyListeners();
  }
}
