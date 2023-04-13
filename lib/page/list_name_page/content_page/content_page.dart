import 'package:flutter/material.dart';
import 'package:newsapp/page/list_name_page/content_page/content_model.dart';
import 'package:newsapp/page/list_name_page/content_page/ui/pdf.dart';
import 'package:provider/provider.dart';
import '../../../list_data.dart';
bool isRed = false;
class ContentPage extends StatefulWidget {
  final String link;
  //final String title;
  // final String subtitle;

  ContentPage({
    Key? key,
    required this.link,
    //required this.title,
    // required this.subtitle,
  }):super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final ContentModel model = ContentModel();



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: model.getData(link: widget.link),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF5E35B1),
              ),
              body: Center(
                child: Image.asset("assets/image/642552b43cf1c.gif"),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("出现错误"),
              ),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF5E35B1),
                title: Text(snapshot.data!.title!),
              ),
              body: Container(
                padding: const EdgeInsets.all(11.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.contents!.length,
                    itemBuilder: (BuildContext context, int index) {
                      switch (snapshot.data!.contents![index].type!) {
                        case "text":
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child:
                                Text(snapshot.data!.contents![index].content!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                          );
                        case "image":
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                                snapshot.data!.contents![index].content!),
                          );
                        case "pdf":
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ContentPDF(
                              url: snapshot.data!.contents![index].content!,
                            ),
                          );
                        default:
                          return Image.asset("assets/image/642552b43cf1c.gif");
                      }
                    }),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if(!isRed){
                    try{
                      Provider.of<NewsListProvider>(context, listen: false).list6.add(widget.link);
                    }catch(e){
                      print(e.toString());
                    }
                  }else{
                    try{
                      Provider.of<NewsListProvider>(context, listen: false).list6.remove(widget.link);
                    }catch(e){
                      print(e.toString());
                    }
                  }
                  setState(() {
                    isRed = !isRed;
                  });
                },
                child: Icon(Icons.favorite,
                    color: isRed ? Colors.red : Colors.white),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(backgroundColor: Color(0xFF5E35B1)),
              body: Center(
                child: Image.asset("assets/image/642552b43cf1c.gif"),
              ),
            );
          }
        });
  }
}
