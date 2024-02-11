//import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';
import 'package:hive/hive.dart';

class Database{

  //db reference
  final _myBox = Hive.box("itemdata");

  List<ItemModel> itemList = [];

  //create the itemlist function
  void createDatabase(){
    itemList = [

      ItemModel(
          amount: 12.50,
          date: DateTime.now(),
          title: "Milk",
          category: Category.dairy),
      ItemModel(
          amount: 15.20,
          date: DateTime.now(),
          title: "Bread",
          category: Category.bakery),
      ItemModel(
          amount: 20.00,
          date: DateTime.now(),
          title: "Mango",
          category: Category.fruits)

    ];
  }

  //load data
  void loadData () {
    final dynamic data = _myBox.get("ITM_DATA");
    //validate data
    if(data != null && data is List<dynamic>){
      itemList = data.cast<ItemModel>().toList();
    }
  }

  //update data
  Future<void> updateData() async {
    await _myBox.put("ITM_DATA", itemList);
    print("data saved");
  }

}