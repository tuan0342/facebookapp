import 'package:flutter/material.dart';

class Emotions extends StatelessWidget {

  List <Emotion> emotionList = [
    Emotion("angry","assets/images/emotions_icon/angry.png"),
    Emotion("cry","assets/images/emotions_icon/cry.png"),
    Emotion("cute","assets/images/emotions_icon/cute.png"),
    Emotion("love","assets/images/emotions_icon/love.png"),
    Emotion("neutral","assets/images/emotions_icon/neutral.png"),
    Emotion("sad","assets/images/emotions_icon/sad.png"),
    Emotion("smile","assets/images/emotions_icon/smile.png"),
    Emotion("smilling","assets/images/emotions_icon/smiling.png"),
    Emotion("star", "assets/images/emotions_icon/star.png")
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

              // chosenEmotion != "" ?
              // Container(
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: EmotionLayOut(chosenEmotion as Emotion)
              //       ),
              //       IconButton(
              //           onPressed:() {
              //             chosenEmotion
              //           },
              //           icon: Icon(Icons.close))
              //     ],
              //   ),
              //
              // ) : SizedBox(),
              SingleChildScrollView(
                child:Expanded(
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
                                chosenEmotion(emotionList[index]);
                                Navigator.pop(context, chosenEmotion);
                              },
                              child: EmotionLayOut(emotionList[index]),
                            ),
                          );
                        }),
                      ),
                    )
                )
                ,
              )

            ],
          )

      ),
    );
  }

  Widget EmotionLayOut(Emotion emotion) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              emotion.iconPath
            ),

          ),
          SizedBox(width: 10),
          Text(
            emotion.status,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18
            )
          )
        ],
      ),
    );
  }

}
typedef void StringCallback(Emotion val);





class Emotion {
  String status;
  String iconPath;
  Emotion(this.status, this.iconPath);
}

