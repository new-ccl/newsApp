import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../list_data.dart';
import 'content_page/content_page.dart';
import 'model.dart';


class ListPage extends StatefulWidget {
  final String type;
   const ListPage({Key? key, required this.type}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  final ScrollController _scrollController = ScrollController();
  int _index = 1;
  bool _isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent-50) {
        if(!_isLoading){
          setState(() {
            _isLoading = true;
          });
          _load();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (!_isLoading) return;
    await _model.getData(type: widget.type, page: ++_index);
      if (_model.getData != null) {
        setState(() {
          _isLoading = false;
        });
      }
  }

  late final NewsListModel _model = NewsListModel();

  Future<dynamic> _future1(String type, {int page = 1}) async {
    return await _model.getData(type: type, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future:_future1(widget.type),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CupertinoScrollbar(
                controller: _scrollController,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      _model.newsList.clear(); // 清空 newsList
                      _index = 1;
                      _model.getData(type: widget.type, page: _index);
                    });
                  },
                  child: ListView.builder(
                      controller: _scrollController,
                      // separatorBuilder: (context,index){
                      //   return const Divider(thickness: 1);
                      // },
                      itemCount:
                      _model.newsList.length + (_isLoading ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) { if (index >= _model.data!.data!.length&&_isLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else{
                        return ListTile(
                            title: Text(_model.newsList[index].title!),
                            subtitle: Text(_model.newsList[index].date!),
                            onTap: () async {
                              try {
                                Provider.of<NewsListProvider>(context, listen: false).list1.add(_model.newsList[index].title!);
                                Provider.of<NewsListProvider>(context, listen: false).list2.add(_model.newsList[index].date!);
                                Provider.of<NewsListProvider>(context, listen: false).list3.add(_model.newsList[index].link!);
                                // print('link: ${_model.newsList[index].link}');
                                // print('title: ${_model.newsList[index].title}');
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContentPage(
                                          link: _model.newsList[index].link!,
                                          //title: _model.newsList[index].title!,
                                          //subtitle: _model.newsList[index].date!,
                                        )));
                              } catch (e) {
                                print(e.toString());
                              }
                            });
                      }
                        }),
                ),
              );
            } else {
              return Center(
                  child: Image.asset(
                      "assets/image/642552b43cf1c.gif"));
            }
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}