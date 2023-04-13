import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_data.dart';
import 'List_name_page/content_page/content_page.dart';

class LovePage extends StatefulWidget {
  const LovePage({Key? key}) : super(key: key);

  @override
  State<LovePage> createState() => _LovePageState();
}

class _LovePageState extends State<LovePage> {
  @override
  Widget build(BuildContext context) {
    final newsListProvider = Provider.of<NewsListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5E35B1),
        title: const Text('我的收藏'),
      ),
      body: ListView.builder(
          itemCount: newsListProvider.list6.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(newsListProvider.list6[index]),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentPage(
                        link: newsListProvider.list6[index],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}