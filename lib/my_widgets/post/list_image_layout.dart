import 'package:facebook_app/models/image_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListImageLayout extends StatelessWidget {
  final int postId;
  final double? fullHeight;
  final List<ImageModel> images;
  const ListImageLayout(
      {super.key, required this.images, required this.postId, this.fullHeight});

  void handleTapImage(BuildContext context) {
    if (images.length > 1) {
      context.push("/authenticated/postDetail/$postId");
    } else {
      showPopupList(context: context, images: [images[0].url]);
    }
  }

  Widget getLayoutByLength(int length, BuildContext context) {
    switch (length) {
      case 1:
        {
          return GestureDetector(
            onTap: () {
              handleTapImage(context);
            },
            child: MyImage(
              width: double.infinity,
              imageUrl: images[0].url,
              shape: BoxShape.rectangle,
              fit: BoxFit.contain,
            ),
          );
        }
      case 2:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: GestureDetector(
                  onTap: () {
                    handleTapImage(context);
                  },
                  child: MyImage(
                    imageUrl: images[0].url,
                    width: double.infinity,
                    height: double.infinity,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: GestureDetector(
                  onTap: () {
                    handleTapImage(context);
                  },
                  child: MyImage(
                    imageUrl: images[1].url,
                    width: double.infinity,
                    height: double.infinity,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                  ),
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
                child: GestureDetector(
                  onTap: () {
                    handleTapImage(context);
                  },
                  child: MyImage(
                    imageUrl: images[0].url,
                    width: double.infinity,
                    height: double.infinity,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: GestureDetector(
                            onTap: () {
                              handleTapImage(context);
                            },
                            child: MyImage(
                              imageUrl: images[1].url,
                              width: double.infinity,
                              height: double.infinity,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: GestureDetector(
                            onTap: () {
                              handleTapImage(context);
                            },
                            child: MyImage(
                              imageUrl: images[2].url,
                              width: double.infinity,
                              height: double.infinity,
                              shape: BoxShape.rectangle,
                            ),
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
                child: GestureDetector(
                  onTap: () {
                    handleTapImage(context);
                  },
                  child: MyImage(
                    imageUrl: images[0].url,
                    width: double.infinity,
                    height: double.infinity,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: GestureDetector(
                            onTap: () {
                              handleTapImage(context);
                            },
                            child: MyImage(
                              imageUrl: images[1].url,
                              width: double.infinity,
                              height: double.infinity,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: GestureDetector(
                            onTap: () {
                              handleTapImage(context);
                            },
                            child: MyImage(
                              imageUrl: images[2].url,
                              width: double.infinity,
                              height: double.infinity,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: GestureDetector(
                            onTap: () {
                              handleTapImage(context);
                            },
                            child: MyImage(
                              imageUrl: images[3].url,
                              width: double.infinity,
                              height: double.infinity,
                              shape: BoxShape.rectangle,
                            ),
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
    return SizedBox(
        width: double.infinity,
        height: fullHeight,
        child: getLayoutByLength(images.length, context));
  }
}
