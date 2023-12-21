import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListImageLayout extends StatefulWidget {

  final List<File> images;
  final ListCallback cbFunction;
  final double? fullHeight;

  const ListImageLayout(
      {super.key, required this.images, this.fullHeight, required this.cbFunction});


  @override
  State<ListImageLayout> createState() {
    return _imageListState ();
  }
}
typedef void ListCallback(List<File> val);


class _imageListState extends State<ListImageLayout>  {
  Widget getLayoutByLength(int length, BuildContext context) {
    switch (length) {
      case 1:
        {
          return
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Image(
                    image: FileImage(widget.images[0]),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.images.removeAt(0);
                        widget.cbFunction(widget.images);
                      });

                    },
                    child: const Icon(Icons.close,
                        color: Colors.black),
                  ),
                ),
              ],
            );
        }
      case 2:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(widget.images[0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(0);
                              widget.cbFunction(widget.images);

                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(widget.images[1]),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(1);
                              widget.cbFunction(widget.images);

                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ],
        );
      case 3:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(widget.images[0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(0);
                              widget.cbFunction(widget.images);

                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Image(
                                    image: FileImage(widget.images[1]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.images.removeAt(1);
                                        widget.cbFunction(widget.images);

                                      });
                                    },
                                    child: const Icon(Icons.close,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Image(
                                    image: FileImage(widget.images[2]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.images.removeAt(2);
                                        widget.cbFunction(widget.images);

                                      });
                                    },
                                    child: const Icon(Icons.close,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 4:
        return Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(widget.images[0]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(0);
                                    widget.cbFunction(widget.images);

                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(widget.images[1]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(1);
                                    widget.cbFunction(widget.images);

                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )

            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(widget.images[3]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(2);
                                    widget.cbFunction(widget.images);

                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(widget.images[3]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(3);
                                    widget.cbFunction(widget.images);

                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ],
        );
      default:
        return Container();
    }

  }


  @override
  Widget  build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 400,
        child: getLayoutByLength(widget.images.length, context));
  }

}