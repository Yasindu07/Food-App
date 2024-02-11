import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

final uuid = const Uuid().v4();

final formatedDate = DateFormat.yMd();

enum Category{vegetables, fruits, dairy, beverages, meats, bakery}

//Category Icon
/*final CategoryIcon = {

}*/

@HiveType(typeId: 1)

class ItemModel {

  ItemModel(
      {required this.amount,
        required this.date,
        required this.title,
        required this.category})
        :id = uuid;

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  String get getFormatedDate{
    return formatedDate.format(date);
  }
}
