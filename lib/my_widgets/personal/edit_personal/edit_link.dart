import 'package:facebook_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class EditLink extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final bool isEditLink;
  final TextEditingController linkController;
  final void Function() setIsEditLink;
  const EditLink(
      {super.key,
      required this.contextPage,
      required this.profile,
      required this.isEditLink,
      required this.linkController,
      required this.setIsEditLink});

  @override
  State<EditLink> createState() => _EditLinkState();
}

class _EditLinkState extends State<EditLink> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text(
              'Liên kết',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                widget.setIsEditLink();
              },
              child: Text(
                widget.isEditLink ? 'Đặt lại' : 'Chỉnh sửa',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Icon(Icons.link, color: Colors.black54, size: 28),
            const SizedBox(
              width: 10,
            ),
            widget.isEditLink
                ? SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 100,
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      controller: widget.linkController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          labelText: "Nhập link trang cá nhân"),
                      validator: (value) {
                        return null;
                      },
                    ),
                  )
                : Flexible(
                    child: Text(
                    widget.profile.link,
                    style: const TextStyle(fontSize: 18),
                  )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
