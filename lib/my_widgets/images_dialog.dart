import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagesDialog extends StatefulWidget {
  final int index;
  final List<String> images;
  const ImagesDialog({super.key, required this.images, required this.index});

  @override
  State<ImagesDialog> createState() => _ImagesDialogState();
}

class _ImagesDialogState extends State<ImagesDialog> {
  late int currentIndex = widget.index;
  late String currentImage = widget.images[currentIndex];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      elevation: 0.0,
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0,right: 0.0),
      child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 18.0,),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 10,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                  ),
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.images.isEmpty == 0 ? IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 50,),
                        onPressed: () {
                          setState(() {
                            if(currentIndex > 0) {
                              currentIndex -= 1;
                            }
                          });
                        },
                      ) : const SizedBox() ,
                      // MyImage(imageUrl: widget.images[currentIndex], shape: BoxShape.rectangle, fit: BoxFit.contain, height: MediaQuery.of(context).size.height - 100, width: MediaQuery.of(context).size.width - 100),
                      CachedNetworkImage(
                        imageUrl: widget.images[currentIndex],
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: MediaQuery.of(context).size.height - 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: MediaQuery.of(context).size.height - 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.contain
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height - 100,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.contain
                            )
                          ),
                        )
                      ),
                      widget.images.isEmpty == 0 ? IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.chevron_right, color: Colors.white, size: 50,),
                        onPressed: () {
                          setState(() {
                            if(currentIndex < widget.images.length - 1) {
                              currentIndex += 1;
                            }
                          });
                        },
                      ) : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black, size: 26,),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
