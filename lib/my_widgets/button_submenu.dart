import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonSubmenu extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final String route;

  const ButtonSubmenu({
    super.key, 
    required this.title, 
    required this.icon,
    required this.description,
    required this.route
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: (){
          context.push(route);
        }, 
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Image.asset(icon, height: 35, width: 35)
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 13, 0, 5),
                    child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 18.0),),
                  ),
                  Text(description, style: const TextStyle(color: Color.fromARGB(255, 105, 105, 105)),)
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}