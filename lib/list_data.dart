import 'package:flutter/material.dart';

class NewsListProvider with ChangeNotifier {
  List<String> list1 = [];
  List<String> list2 = [];
  List<String> list3 = [];
  List<String> list6 = [];
  void addToList(String title, String date) {
    if (!list1.contains(title)) {
      list1.add(title);
    }
    if (!list2.contains(date)) {
      list2.add(date);
    }
    notifyListeners(); // 通知所有订阅者状态已经改变
  }

  void cleanList() {
    list1.clear();
    list2.clear();
    notifyListeners(); // 通知所有订阅者状态已经改变
  }
}