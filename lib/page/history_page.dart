import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_data.dart';
import 'List_name_page/content_page/content_page.dart';

class HisPage extends StatefulWidget {
  const HisPage({Key? key}) : super(key: key);

  @override
  State<HisPage> createState() => _HisPageState();
}

class _HisPageState extends State<HisPage> {
  @override
  @override
  Widget build(BuildContext context) {
    final newsListProvider = Provider.of<NewsListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5E35B1),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  newsListProvider.list1.clear();
                  newsListProvider.list2.clear();
                });
              },
              icon: Icon(Icons.delete_forever))
        ],
        title: const Text('历史记录'),
      ),
      body: ListView.builder(
          itemCount: newsListProvider.list1.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(newsListProvider.list1[index]),
                subtitle: Text(newsListProvider.list2[index]),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentPage(
                        link: newsListProvider.list3[index],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
