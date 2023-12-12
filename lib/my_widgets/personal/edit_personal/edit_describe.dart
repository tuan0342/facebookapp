import 'package:facebook_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class EditDescribe extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final bool isEditDescription;
  final TextEditingController descriptionController;
  final void Function() setIsEditDescription;
  const EditDescribe(
      {super.key,
      required this.contextPage,
      required this.profile,
      required this.isEditDescription,
      required this.descriptionController,
      required this.setIsEditDescription});

  @override
  State<EditDescribe> createState() => _EditDescribeState();
}

class _EditDescribeState extends State<EditDescribe> {
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
              'Mô tả',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                widget.setIsEditDescription();
              },
              child: Text(
                widget.isEditDescription ? 'Đặt lại' : 'Chỉnh sửa',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(Icons.description, color: Colors.black54, size: 28),
            const SizedBox(
              width: 10,
            ),
            widget.isEditDescription
                ? SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 100,
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      controller: widget.descriptionController,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          labelText: "Nhập mô tả"),
                      validator: (value) {
                        return null;
                      },
                    ),
                  )
                : Flexible(
                    child: Text(
                    widget.profile.description,
                    style: const TextStyle(fontSize: 18),
                  )),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(
          height: 1.0,
          width: double.infinity,
          child: DecoratedBox(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 220, 223, 226)),
          ),
        ),
      ],
    );
  }
}
