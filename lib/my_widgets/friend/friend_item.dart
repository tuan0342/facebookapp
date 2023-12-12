import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/friend_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendItem extends StatelessWidget {
  final FriendModel friend;
  const FriendItem({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: (MediaQuery.of(context).size.width - 60) / 3,
      child: TextButton(
        onPressed: () {
          context.push('/authenticated/personalPage/${friend.id}');
        },
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: friend.avatar,
                imageBuilder: (context, imageProvider) => Container(
                      width: (MediaQuery.of(context).size.width - 60) / 3,
                      height: (MediaQuery.of(context).size.width - 60) / 3,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                placeholder: (context, url) => Container(
                      height: (MediaQuery.of(context).size.width - 60) / 3,
                      width: (MediaQuery.of(context).size.width - 60) / 3,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                errorWidget: (context, url, error) => Container(
                      height: (MediaQuery.of(context).size.width - 60) / 3,
                      width: (MediaQuery.of(context).size.width - 60) / 3,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover)),
                    )),
            const SizedBox(
              height: 8,
            ),
            Text(
              friend.username,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
