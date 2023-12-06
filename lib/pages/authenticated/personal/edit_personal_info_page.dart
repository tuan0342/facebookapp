import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final Profile profile;
  const EditPersonalInfoPage({super.key, required this.profile});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    // final Profile extraString = GoRouterState.of(context).extra! as Profile;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Cài đặt trang cá nhân"),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5.0,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFc9ccd1)
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                      child: Column(
                        children: [
                          EditAvatar(),
                          
                          EditCoverImage(),

                          EditInfo(), 
                        ],
                      )
                    ),
                  ],
                ),
              )
            ),
          ]
        )
      ),
    );
  }

  Widget EditAvatar() {
    return Column(
      children: [
        Row(
          children: [
            const Text('Ảnh đại diện', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            const Spacer(),
            TextButton(
              onPressed: (){}, 
              child: const Text('Chỉnh sửa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.blue),),
            ),
          ],
        ),
        ButtonTheme(
          height: 140,
          minWidth: 140,
          child: TextButton(
            onPressed: (){},
            child: CachedNetworkImage(
              imageUrl: widget.profile.avatar,
              imageBuilder: (context, imageProvider) => Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                  border: Border.all(width: 3, color: Colors.white)
                ),
              ),
              placeholder: (context, url) => Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/male_default_avatar.jpeg"),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 140,
                width: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, 
                  image: DecorationImage(
                    image: AssetImage("assets/images/male_default_avatar.jpeg"),
                    fit: BoxFit.cover
                  )
                ),
              )
            ),
          )
        ),
        const SizedBox(height: 10,),
        const SizedBox(
          height: 1.0,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 223, 226)
            ),
          ),
        ),
      ],
    );
  }

  Widget EditCoverImage() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            const Text('Ảnh bìa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            const Spacer(),
            TextButton(
              onPressed: (){}, 
              child: const Text('Chỉnh sửa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.blue),),
            ),
          ],
        ),
        ButtonTheme(
          height: 200,
          minWidth: MediaQuery.of(context).size.width - 20,
          child: TextButton(
            onPressed: (){},
            child: CachedNetworkImage(
              imageUrl: widget.profile.imageCover,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              placeholder: (context, url) => Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/male_default_avatar.jpeg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, 
                  image: const DecorationImage(
                    image: AssetImage("assets/images/male_default_avatar.jpeg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ),
          )
        ),
        const SizedBox(height: 10,),
        const SizedBox(
          height: 1.0,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 223, 226)
            ),
          ),
        ),
      ],
    );
  }

  Widget EditInfo() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            const Text('Chi tiết', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            const Spacer(),
            TextButton(
              onPressed: (){}, 
              child: const Text('Chỉnh sửa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.blue),),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Visibility(
          visible: !widget.profile.address.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.black54, size: 28),
              const SizedBox(width: 10,),
              Text('Đến từ ${widget.profile.address}', style: const TextStyle(fontSize: 18),)
            ],
          ),
        ),
        const SizedBox(height: 15,),
        Visibility(
          visible: !widget.profile.city.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.home, color: Colors.black54, size: 28),
              const SizedBox(width: 10,),
              Text('Sống tại ${widget.profile.address}', style: const TextStyle(fontSize: 18),)
            ],
          ),
        ),
        const SizedBox(height: 15,),
        Visibility(
          visible: widget.profile.listing.isNotEmpty,
          child: Row(
            children: [
              const Icon(Icons.rss_feed, color: Colors.black54, size: 26),
              const SizedBox(width: 10,),
              Text('Có ${widget.profile.listing} người theo dõi', style: const TextStyle(fontSize: 18),)
            ],
          ),
        ),
      ],
    );
  }
}
