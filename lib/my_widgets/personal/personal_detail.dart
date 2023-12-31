import 'package:facebook_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class PersonalDetail extends StatelessWidget {
  final Profile profile;
  final BuildContext contextPage;
  const PersonalDetail(
      {super.key, required this.profile, required this.contextPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Chi tiết',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: profile.address.isNotEmpty ? 20 : 0),
        Visibility(
          visible: profile.address.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.black54, size: 28),
              const SizedBox(width: 10),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Đến từ ',
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                    children: [
                      TextSpan(
                        text: profile.address,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: profile.city.isNotEmpty ? 10 : 0),
        Visibility(
          visible: profile.city.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.home, color: Colors.black54, size: 28),
              const SizedBox(width: 10),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Sống tại ',
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                    children: [
                      TextSpan(
                        text: profile.city,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Visibility(
        //   visible: profile.listing.isNotEmpty,
        //   child: Row(
        //     children: [
        //       const Icon(Icons.rss_feed, color: Colors.black54, size: 26),
        //       const SizedBox(width: 10),
        //       Flexible(
        //           child: Text(
        //         'Có ${profile.listing} người theo dõi',
        //         style: const TextStyle(fontSize: 18),
        //       )),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
