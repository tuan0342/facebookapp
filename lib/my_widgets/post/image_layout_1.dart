import 'package:facebook_app/models/image_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:flutter/material.dart';

class LayoutOneImage extends StatelessWidget {
  final List<ImageModel> images;
  const LayoutOneImage({super.key, required this.images});

  Widget getLayoutByLength(int length) {
    switch (length) {
      case 1:
        {
          return Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: MyImage(
                      imageUrl: images[0].url,
                      width: double.infinity,
                      height: double.infinity,
                      shape: BoxShape.rectangle,
                      fit: BoxFit.contain,
                    ),
                  )),
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
                child: MyImage(
                  imageUrl: images[0].url,
                  width: double.infinity,
                  height: double.infinity,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: MyImage(
                  imageUrl: images[1].url,
                  width: double.infinity,
                  height: double.infinity,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                ),
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
                child: MyImage(
                  imageUrl: images[0].url,
                  width: double.infinity,
                  height: double.infinity,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: MyImage(
                            imageUrl: images[1].url,
                            width: double.infinity,
                            height: double.infinity,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: MyImage(
                            imageUrl: images[2].url,
                            width: double.infinity,
                            height: double.infinity,
                            shape: BoxShape.rectangle,
                          ),
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
              child: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: MyImage(
                  imageUrl: images[0].url,
                  width: double.infinity,
                  height: double.infinity,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: MyImage(
                            imageUrl: images[1].url,
                            width: double.infinity,
                            height: double.infinity,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: MyImage(
                            imageUrl: images[2].url,
                            width: double.infinity,
                            height: double.infinity,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: MyImage(
                            imageUrl: images[3].url,
                            width: double.infinity,
                            height: double.infinity,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: getLayoutByLength(images.length));
  }
}
