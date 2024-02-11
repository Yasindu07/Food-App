import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';
//import 'package:food_app/models/item.dart';


class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  item.amount.toStringAsFixed(2),
                ),

                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.trending_down),
                    const SizedBox(width: 8,
                    ),
                    Text(item.getFormatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
