import 'package:flutter/material.dart';

class Emotions extends StatelessWidget {

  List <Emotion> emotionList = [
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
    Emotion("happy","assets/images/emotions_icon/icon_1.svg"),
  ];

  late final StringCallback chosenEmotion;
  Emotions({required this.chosenEmotion});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Text("Bạn đang cảm thấy thế nào?"),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      childAspectRatio: 3.3,
                      children: List.generate(emotionList.length, (index) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: OutlinedButton(
                            onPressed: (){
                                chosenEmotion(emotionList[index].status);
                                Navigator.pop(context, chosenEmotion);
                            },
                            child: Row(
                              children: [
                                Container(
                                    height: 20,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Image.asset(emotionList[index].iconPath),
                                        Icon(Icons.emoji_emotions),
                                        SizedBox(width: 10,),
                                        Text(emotionList[index].status, style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
                                      ],
                                    ))

                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )
              )


            ],
          )

      ),
    );
  }

}
typedef void StringCallback(String val);



class Emotion {
  String status;
  String iconPath;
  Emotion(this.status, this.iconPath);
}

