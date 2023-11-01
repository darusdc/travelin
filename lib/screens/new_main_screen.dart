import 'package:flutter/material.dart';
import 'package:travelin/components/header/header.dart';

List<String> cities = ['Bali', 'Jakarta', 'Bandung'];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String dropDownValue = cities.first;

  @override
  Widget build(BuildContext context) {
    newText(String value) {
      setState(() {
        dropDownValue = value;
      });
    }

    // List<DropdownMenuItem> cityDropDown = [
    //   DropdownMenuItem(child: Text("Jakarta"))
    // ];
    // cityDropDown.add([
    //   'Bali',
    //   'Jakarta',
    //   'Bandung'
    // ].map((e) => DropdownMenuEntry(value: e, label: e)));
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            Flexible(
                child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              value: dropDownValue,
              items: cities
                  .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                newText(value!);
              },
            ))
          ],
        ),
      ),
    );
  }
}
