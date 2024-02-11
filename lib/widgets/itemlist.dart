import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';
import 'package:food_app/widgets/item_tile.dart';

class ItemList extends StatelessWidget {
  final List<ItemModel> itemList;
  final void Function (ItemModel item) onDeleteItem;
  const ItemList({super.key, required this.itemList, required this.onDeleteItem});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Dismissible(
              key: ValueKey(itemList[index]),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction){
                onDeleteItem(itemList[index]);
              },
              child: ItemTile(
                item: itemList[index],
              ),
            ),
          );

        },
      ),
    );
  }
}
