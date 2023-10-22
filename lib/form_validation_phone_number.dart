import 'package:flutter/material.dart';

void main() {
  runApp(PhoneNumberValidation());
}

class PhoneNumberValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown and TextField Example',
      home: Scaffold(
        appBar: AppBar(title: Text('Dropdown and TextField Example')),
        body: Center(
          child: MyRow(),
        ),
      ),
    );
  }
}

class MyRow extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  String dropdownValue = 'Option 1';
  TextEditingController textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                .map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          SizedBox(width: 20),
          Container(
            width: 150,
            child: TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
  }
}
