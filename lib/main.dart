import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';
import 'package:food_app/pages/items.dart';
import 'package:food_app/server/category_adapter.dart';
import 'package:hive_flutter/adapters.dart';

void main()async {
  
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox("itemdata");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Items(),
    );
  }
}

