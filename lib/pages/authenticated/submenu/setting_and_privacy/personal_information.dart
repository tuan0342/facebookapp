import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Thông tin cá nhân"),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Thông tin cá nhân', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Chung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              ),
              
              SizedBox(
                width: double.infinity,
                child: TextButton(
                onPressed: (){
                  context.push('/authenticated/menu/setting/personalInformation/personalName');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Tên", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)
                          ),
                          Text(
                            appService.username, 
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(221, 59, 59, 59))
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(Icons.chevron_right, color: Colors.black54, size: 46), 
                      ),
                    ],
                  )
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}