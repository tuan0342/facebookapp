import 'package:flutter/material.dart';

class PersonalSkeleton extends StatelessWidget {
  const PersonalSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Container(
              height: 240,
            ),
            //cover image
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 10,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            // Positioned(
            //   top: 170,
            //   left: 100,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       shape: const CircleBorder(),
            //       padding: const EdgeInsets.all(10),
            //       backgroundColor: const Color.fromARGB(
            //           255, 219, 219, 219), // <-- Button color
            //       foregroundColor: const Color.fromARGB(
            //           255, 133, 133, 133), // <-- Splash color
            //     ),
            //     child: const Icon(Icons.camera_alt, color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}