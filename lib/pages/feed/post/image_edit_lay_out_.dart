import 'dart:io';

import 'package:facebook_app/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../my_widgets/my_image.dart';

class ListImageEditLayout extends StatefulWidget {
  final List<ImageModel> images;
  final ListCallback cbFunction;
  final UrlListCallBack urlFunction;
  final StringCallBack image_delFunction;
  final double? fullHeight;


  const ListImageEditLayout(
      {super.key, required this.images, this.fullHeight,
        required this.cbFunction, required this.urlFunction, required this.image_delFunction});


  @override
  State<ListImageEditLayout> createState() {
    return _imageListState ();
  }
}
typedef void StringCallBack(String val);
typedef void ListCallback(List<File> val);
typedef void UrlListCallBack(List<ImageModel> val);



class _imageListState extends State<ListImageEditLayout>  {
  Widget getLayoutByLength(int length, BuildContext context) {
    debugPrint("imageLayout: ${widget.images.length}");
    switch (length) {
      case 1:
        {
          return
            Stack(
              children: [
                MyImage(
                  width: double.infinity,
                  imageUrl: widget.images[0].url,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.images.removeAt(0);
                        widget.image_delFunction("0");
                        // widget.cbFunction(widget.images);
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
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,

                        imageUrl: widget.images[0].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(0);
                              widget.image_delFunction("0");

                              // widget.cbFunction(widget.images);
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
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,

                        imageUrl: widget.images[1].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(1);
                              widget.image_delFunction("1");
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
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,

                        imageUrl: widget.images[0].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(0);
                              widget.image_delFunction("0");

                              // widget.cbFunction(widget.images);
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
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Stack(
                              children: [
                                MyImage(
                                  width: double.infinity,
                                  height: double.infinity,

                                  imageUrl: widget.images[1].url,
                                  shape: BoxShape.rectangle,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.images.removeAt(1);
                                        widget.image_delFunction("1");

                                        // widget.cbFunction(widget.images);
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
                                MyImage(
                                  width: double.infinity,
                                  height: double.infinity,

                                  imageUrl: widget.images[2].url,
                                  shape: BoxShape.rectangle,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.images.removeAt(2);
                                        widget.image_delFunction("2");

                                        // widget.cbFunction(widget.images);
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
                        child:Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: double.infinity,

                              imageUrl: widget.images[0].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(0);
                                    widget.image_delFunction("0");

                                    // widget.cbFunction(widget.images);
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
                        child:Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: double.infinity,

                              imageUrl: widget.images[1].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(1);
                                    widget.image_delFunction("1");

                                    // widget.cbFunction(widget.images);
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
                        child:Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: widget.images[2].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(2);
                                    widget.image_delFunction("2");

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
                        child:Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: widget.images[3].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.images.removeAt(3);
                                    widget.image_delFunction("3");
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
        height: widget.fullHeight,
        child: getLayoutByLength(widget.images.length, context));
  }

}