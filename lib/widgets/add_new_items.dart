import 'package:flutter/material.dart';
import 'package:food_app/models/item.dart';

class AddNewItems extends StatefulWidget {

  final void Function(ItemModel item) onAddItem;
  const AddNewItems({super.key, required this.onAddItem});

  @override
  State<AddNewItems> createState() => _AddNewItemsState();
}

class _AddNewItemsState extends State<AddNewItems> {

  final _titleContoller = TextEditingController();
  final _amountContoller = TextEditingController();
  Category _selectCategory = Category.beverages;


  //date variable
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime _selectedDate = DateTime.now();

  //date pick
  Future <void> _openDatePicker() async{
      try{
        final datePicker = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate);

        setState(() {
          _selectedDate = datePicker!;
        });

      }catch(err){
        print(err.toString());
      }
  }

  // Validate submit form
  void _validateForm() {
    // Form validation
    // Convert amount string to double
    final userAmount = double.parse(_amountContoller.text.trim());
    if (_titleContoller.text.trim().isEmpty || userAmount < 0.00) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter Valid Data"),
            content: const Text("Please enter the valid data for the title and the amount"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    }
    else{
      //create new item
      ItemModel newItem = ItemModel(
          amount: userAmount,
          date: _selectedDate,
          title: _titleContoller.text.trim(),
          category: _selectCategory);
      //validate true save data
      widget.onAddItem(newItem);
      Navigator.pop(context);

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleContoller.dispose();
    _amountContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          //title
          TextField(
            controller: _titleContoller,
            decoration: const InputDecoration(
              hintText: "Add new Item",
              labelText: "Title",
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),

          Row(
            children: [
              //amount
              Expanded(
                child: TextField(
                  controller: _amountContoller,
                  decoration: const InputDecoration(
                    hintText: "Enter the Amount",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              //date
              Expanded(child: Row(
                //date
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(formatedDate.format(_selectedDate)),
                  IconButton(
                    onPressed: _openDatePicker,
                    icon: const Icon(Icons.date_range_outlined),
                  ),
                ],
              )),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectCategory,
                items: Category.values.map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectCategory = value!;
                  });

              },
              ),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //close
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                      ),
                      child: const Text("CLOSE"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _validateForm,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    ),
                    child: const Text("SAVE"),
                  ),

                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
