import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
class ContentPDF extends StatefulWidget {
  final String url;

  const ContentPDF({Key? key, required this.url}) : super(key: key);

  @override
  State<ContentPDF> createState() => _ContentPDFState();
}

class _ContentPDFState extends State<ContentPDF> {
  String? pdfFilePath;

  Future<String?> downloadAndSavePdf() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/sample.pdf');
      if (await file.exists()) {
        return file.path;
      }
      final response = await Dio().get(widget.url,options: Options(responseType:ResponseType.bytes ));
      await file.writeAsBytes(response.data);
      return file.path;
    } catch (e) {
      print("下载PDF文件失败：$e");
      return null;
    }
  }

  Future<void> disposeFile() async {
    if (pdfFilePath != null) {
      final file = File(pdfFilePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    disposeFile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: downloadAndSavePdf(), // 使用 loadPdf 方法来下载并保存 PDF 文件
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text("加载中");
        }
        return PdfView(path: snapshot.data!);},
    );
  }
}