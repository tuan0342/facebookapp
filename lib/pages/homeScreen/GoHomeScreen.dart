
import 'package:flutter/material.dart';

class GoHomeScreen extends StatelessWidget {
  const GoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: Colors.grey,
              height: 0.4,
            ),
          ),
          automaticallyImplyLeading: true,
          elevation: 0.0, // for elevation
          titleSpacing: 0.0, // if you want remove title spacing with back button
          title: Material(
            //Custom leading icon, such as back icon or other icon
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  // context.pop();
                },
                child: TextButton(
                  onPressed: (){},
                  // padding: const EdgeInsets.fromLTRB(12.0, 16.0, 16.0, 16.0),
                  child: Text('Facebook', style: TextStyle(color: Colors.blue),),
                )

            )
          )
    )
    );
  }



}