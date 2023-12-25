import 'dart:io';

import 'package:facebook_app/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../my_widgets/my_image.dart';

class ListImageEditLayout extends StatefulWidget {
  final List<ImageModel> images;
  final List<File> newImages;
  final ListCallback cbFunction;

  final UrlListCallBack urlFunction;
  final StringCallBack image_delFunction;

  final double? fullHeight;


  const ListImageEditLayout(
      {super.key, required this.images,
        required this.newImages
        , this.fullHeight,

        required this.cbFunction,
        required this.urlFunction,
        required this.image_delFunction,
       });


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
          return (widget.images[0].url.contains("http")) ?
            Stack(
              children: [
                MyImage(
                  width: double.infinity,
                  imageUrl: widget.images[0].url,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.image_delFunction("${widget.images[0].id}");
                        widget.images.removeAt(0);
                        widget.urlFunction(widget.images);
                      });
                    },
                    child: const Icon(Icons.close,
                        color: Colors.black),
                  ),
                ),
              ],
            ):
            Stack(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Image(
                  image: FileImage(new File(widget.images[0].url)),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.images.removeAt(0);
                      widget.newImages.removeAt(0);
                      widget.cbFunction(widget.newImages);
                      widget.urlFunction(widget.images);
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
                  child: (widget.images[0].url.contains("http")) ?
                  Stack(
                    children: [
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl: widget.images[0].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.image_delFunction("${widget.images[0].id}");
                              widget.images.removeAt(0);
                              widget.urlFunction(widget.images);

                              // widget.cbFunction(widget.images);
                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ):
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(new File(widget.images[0].url)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.images.removeAt(0);
                              deleteNewImageFile(widget.images[0]);
                              widget.urlFunction(widget.images);
                              widget.cbFunction(widget.newImages);
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
                  child: (widget.images[1].url.contains("http")) ?
                  Stack(
                    children: [
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl: widget.images[1].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.image_delFunction("${widget.images[1].id}");

                              widget.images.removeAt(1);
                              widget.urlFunction(widget.images);
                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ):
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(new File(widget.images[1].url)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              deleteNewImageFile(widget.images[1]);
                              widget.images.removeAt(1);
                              widget.urlFunction(widget.images);
                              widget.cbFunction(widget.newImages);
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
                  child: (widget.images[0].url.contains("http")) ?
                  Stack(
                    children: [
                      MyImage(
                        width: double.infinity,
                        height: double.infinity,

                        imageUrl: widget.images[0].url,
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.image_delFunction("${widget.images[0].id}");
                              widget.images.removeAt(0);
                              widget.urlFunction(widget.images);
                            });
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ):
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          image: FileImage(new File(widget.images[0].url)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              deleteNewImageFile(widget.images[0]);
                              widget.images.removeAt(0);
                              widget.urlFunction(widget.images);
                              widget.cbFunction(widget.newImages);
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
                  height: 400,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: (widget.images[1].url.contains("http")) ?
                            Stack(
                              children: [
                                MyImage(
                                  width: double.infinity,
                                  height: double.infinity,

                                  imageUrl: widget.images[1].url,
                                  shape: BoxShape.rectangle,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.image_delFunction("${widget.images[1].id}");

                                        widget.images.removeAt(1);
                                        widget.urlFunction(widget.images);

                                        // widget.cbFunction(widget.images);
                                      });
                                    },
                                    child: const Icon(Icons.close,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ):
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Image(
                                    image: FileImage(new File(widget.images[1].url)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        deleteNewImageFile(widget.images[1]);

                                        widget.images.removeAt(1);
                                        widget.cbFunction(widget.newImages);
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
                            child: (widget.images[2].url.contains("http")) ?
                            Stack(
                              children: [
                                MyImage(
                                  width: double.infinity,
                                  height: double.infinity,

                                  imageUrl: widget.images[2].url,
                                  shape: BoxShape.rectangle,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.image_delFunction("${widget.images[2].id}");

                                        widget.images.removeAt(2);
                                        widget.urlFunction(widget.images);

                                      });
                                    },
                                    child: const Icon(Icons.close,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ):
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Image(
                                    image: FileImage(new File(widget.images[2].url)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        deleteNewImageFile(widget.images[2]);
                                        widget.images.removeAt(2);
                                        widget.urlFunction(widget.images);
                                        widget.cbFunction(widget.newImages);
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
                        child: (widget.images[0].url.contains("http")) ?
                        Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height:200,
                              imageUrl: widget.images[0].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.image_delFunction("${widget.images[0].id}");

                                    widget.images.removeAt(0);
                                    widget.urlFunction(widget.images);
                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ):
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(new File(widget.images[0].url)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deleteNewImageFile(widget.images[0]);
                                    widget.images.removeAt(0);
                                    widget.urlFunction(widget.images);
                                    widget.cbFunction(widget.newImages);
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
                        child:(widget.images[1].url.contains("http")) ?
                        Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height:200,

                              imageUrl: widget.images[1].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.image_delFunction("${widget.images[1].id}");

                                    widget.images.removeAt(1);
                                    widget.urlFunction(widget.images);
                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ):
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(new File(widget.images[1].url)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deleteNewImageFile(widget.images[1]);

                                    widget.images.removeAt(1);
                                    widget.urlFunction(widget.images);
                                    widget.cbFunction(widget.newImages);
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
                        child: (widget.images[2].url.contains("http")) ?
                        Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: 200,
                              imageUrl: widget.images[2].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.image_delFunction("${widget.images[2].id}");

                                    widget.images.removeAt(2);
                                    widget.urlFunction(widget.images);
                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ):
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height:200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(new File(widget.images[2].url)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deleteNewImageFile(widget.images[2]);

                                    widget.images.removeAt(2);
                                    widget.urlFunction(widget.images);
                                    widget.cbFunction(widget.newImages);
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
                        child: (widget.images[3].url.contains("http")) ?
                        Stack(
                          children: [
                            MyImage(
                              width: double.infinity,
                              height: 200,
                              imageUrl: widget.images[3].url,
                              shape: BoxShape.rectangle,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.image_delFunction("${widget.images[3].id}");
                                    widget.images.removeAt(3);
                                    widget.urlFunction(widget.images);
                                  });
                                },
                                child: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ) :
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image(
                                image: FileImage(new File(widget.images[3].url)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deleteNewImageFile(widget.images[3]);
                                    widget.images.removeAt(3);
                                    widget.urlFunction(widget.images);
                                    widget.cbFunction(widget.newImages);
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
  void deleteNewImageFile(ImageModel newImageFile){
    widget.newImages.forEach((image) {
      if (image.path == newImageFile.url) {
        int index = widget.newImages.indexOf(image);
        widget.newImages.removeAt(index);
      }
    });
  }


  @override
  Widget  build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: widget.fullHeight,
        child: getLayoutByLength(widget.images.length, context));
  }

}