import 'package:facebook_app/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key, required this.title, required this.iconOfTitle, required this.arrayList,});

  final String title;
  final String iconOfTitle;
  final List<MenuItem> arrayList;

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
                child: Image.asset(widget.iconOfTitle, height: 35, width: 35,)
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
          height: isDropdownVisible ? getHeightOfList(widget.arrayList) : 0.0,
          child: ListView(
            children: getListOptions(widget.arrayList)
          ),
        ),
        // ),
      ],
    );
  }

  List<Widget> getListOptions(List<MenuItem> array) {
    final listOption = <Widget>[];
    for (var i=0; i< array.length; i++) {
      listOption.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: ElevatedButton(
            onPressed: () {
              context.push(array[i].route);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Image.asset(array[i].icon, height: 35, width: 35,)
                  ),
                  Text(
                    array[i].title, 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }

    return listOption;
  }

  double getHeightOfList(List array) {
    return 65.0 * array.length;
  }
}