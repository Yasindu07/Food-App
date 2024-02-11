import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';
import 'package:food_app/widgets/add_new_items.dart';
import 'package:food_app/widgets/itemlist.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

import '../server/database.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final _myBox = Hive.box("itemdata");
  Database db = Database();

  //pie chart
  Map<String, double> dataMap = {
    "vegetables": 0,
    "fruits": 0,
    "dairy": 0,
    "beverages": 0,
    "meats": 0,
    "bakery": 0,
  };

  //add new items
  void onAddNewItem (ItemModel item){
    setState(() {
      db.itemList.add(item);
      calCategoryValues();
    });
    db.updateData();
  }

  //remove item
  void onDeleteItem (ItemModel item){

    //store the item
    ItemModel dltItem = item;
    //get the deleting index
    final int removeIndex = db.itemList.indexOf(item);
    setState(() {
      db.itemList.remove(item);
      db.updateData();
      calCategoryValues();
    });

    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Item Delete Successfull"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                db.itemList.insert(removeIndex, dltItem);
                db.updateData();
                calCategoryValues();
              });
            }
        ),
      )
    );
  }

  double vegetablesVal = 0;
  double fruitsVal = 0;
  double dairyVal = 0;
  double beveragesVal = 0;
  double meatsVal = 0;
  double bakeryVal = 0;

  void calCategoryValues() {
    double vegetablesTot = 0;
    double fruitsTot = 0;
    double dairyTot = 0;
    double beveragesTot = 0;
    double meatsTot = 0;
    double bakeryTot = 0;

    for(final item in db.itemList){

      if(item.category == Category.vegetables){
        vegetablesTot += item.amount;
      }
      if(item.category == Category.fruits){
        fruitsTot += item.amount;
      }
      if(item.category == Category.dairy){
        dairyTot += item.amount;
      }
      if(item.category == Category.beverages){
        beveragesTot += item.amount;
      }
      if(item.category == Category.meats){
        meatsTot += item.amount;
      }
      if(item.category == Category.bakery){
        bakeryTot += item.amount;
      }
    }
    setState(() {
      vegetablesVal = vegetablesTot;
      fruitsVal = fruitsTot;
      dairyVal = dairyTot;
      beveragesVal = beveragesTot;
      meatsVal = meatsTot;
      bakeryVal = bakeryTot;
    });

    //update dataMap
    dataMap = {
      "vegetables": vegetablesVal,
      "fruits": fruitsVal,
      "dairy": dairyVal,
      "beverages": beveragesVal,
      "meats": meatsVal,
      "bakery": bakeryVal,
    };
  }

  @override
  void initState() {
    super.initState();
    //first_time see create the initial data
    if(_myBox.get("ITM_DATA") == null){
      db.createDatabase();
      calCategoryValues();
    }else{
      db.loadData();
      calCategoryValues();
    }


  }

  //function to open model
  void _openAddItem(){

    showModalBottomSheet(
      context: context,
      builder: (context) { 
        return AddNewItems(
          onAddItem: onAddNewItem,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Mart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),),
        backgroundColor:  Colors.deepOrange,
        elevation: 0,
        actions: [
          Container(
            color: Colors.yellowAccent,
            child: IconButton(
              onPressed: _openAddItem,
              icon: const Icon(Icons.add,
              color: Colors.black),
          ),
          ),
        ],
      ),
      
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ItemList(
            itemList: db.itemList,
            onDeleteItem: onDeleteItem,),
        ],
      ),
    );
  }
}
