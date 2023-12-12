import 'package:facebook_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class EditDetail extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final bool isEditDetail;
  final TextEditingController cityController;
  final TextEditingController addressController;
  final void Function() setIsEditDetail;
  const EditDetail(
      {super.key,
      required this.contextPage,
      required this.profile,
      required this.isEditDetail,
      required this.cityController,
      required this.addressController,
      required this.setIsEditDetail});

  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
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
              'Chi tiết',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                widget.setIsEditDetail();
              },
              child: Text(
                widget.isEditDetail ? 'Đặt lại' : 'Chỉnh sửa',
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
        Visibility(
          visible: widget.profile.address.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.black54, size: 28),
              const SizedBox(
                width: 10,
              ),
              widget.isEditDetail
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 40,
                      child: TextFormField(
                        controller: widget.addressController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            labelText: "Nhập địa chỉ"),
                        validator: (value) {
                          return null;
                        },
                      ),
                    )
                  : Flexible(
                      child: Text(
                      'Đến từ ${widget.profile.address}',
                      style: const TextStyle(fontSize: 18),
                    )),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Visibility(
          visible: widget.profile.city.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.home, color: Colors.black54, size: 28),
              const SizedBox(
                width: 10,
              ),
              widget.isEditDetail
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 40,
                      child: TextFormField(
                        controller: widget.cityController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            labelText: "Nhập thành phố"),
                        validator: (value) {
                          return null;
                        },
                      ),
                    )
                  : Flexible(
                      child: Text(
                      'Sống tại ${widget.profile.city}',
                      style: const TextStyle(fontSize: 18),
                    )),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        widget.profile.link.isNotEmpty
            ? const SizedBox(
                height: 1.0,
                width: double.infinity,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 220, 223, 226)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
