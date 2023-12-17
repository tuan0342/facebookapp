import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyImage extends StatelessWidget {
  final String imageUrl;
  final BoxShape shape;
  final BoxFit fit;
  Widget? placeOrderImage;
  Widget? errorImage;
  final double? height;
  final double width;

  MyImage(
      {super.key,
      this.shape = BoxShape.circle,
      this.fit = BoxFit.cover,
      required this.imageUrl,
      this.height,
      this.width = 100,
      this.placeOrderImage,
      this.errorImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(shape: shape),
              child: Image(
                image: imageProvider,
                fit: fit,
              ),
            ),
        placeholder: (context, url) =>
            placeOrderImage ??
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  shape: shape,
                  image: DecorationImage(
                      image: const AssetImage(
                          "assets/images/male_default_avatar.jpeg"),
                      fit: fit)),
            ),
        errorWidget: (context, url, error) =>
            errorImage ??
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  shape: shape,
                  image: DecorationImage(
                      image: const AssetImage(
                          "assets/images/male_default_avatar.jpeg"),
                      fit: fit)),
            ));
  }
}
