import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key, required this.title});

  final String title;

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isDropdownVisible = !isDropdownVisible;
            });
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image.asset("assets/images/question_icon.png", height: 35, width: 35,)
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                width: 5,
              ),
              const Spacer(),
              const RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon( 
                    Icons.chevron_right,
                    size: 28.0,
                    color: Colors.black54,
                  ), 
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isDropdownVisible ? 150.0 : 0.0,
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button click
                },
                child: Text('Option 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button click
                },
                child: Text('Option 2'),
              ),
              // Add more buttons as needed
            ],
          ),
        ),
        // ),
      ],
    );
  }
}