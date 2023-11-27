import 'package:facebook_app/models/feed_model.dart';
import 'package:flutter/material.dart';

class FeedBox extends StatelessWidget{
  Feed feed;
  final Function() ontap;
  FeedBox({required this.feed,required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(feed.userImage),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(feed.userName, style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      const SizedBox(height: 3,),
                      Text(feed.feedTime, style: const TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, size: 30, color: Colors.grey[600],),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
              padding: const EdgeInsets.only(left: 10) ,
              child: Text(feed.feedContent, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
          ),
          const SizedBox(height: 20,),
          feed.feedImageList.length != 0 ?
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(feed.feedImageList[0]),
                    fit: BoxFit.cover
                )
            ),
          ) : Container(),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: [
                        makeKudos(),
                        const SizedBox(width: 5,),
                        Text("${feed.kudosNumber}", style: TextStyle(fontSize: 15, color: Colors.grey[800]),),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Row(
                      children: [
                        makeDisappointed(),
                        const SizedBox(width: 5,),
                        Text("${feed.disappointedNumber}", style: TextStyle(fontSize: 15, color: Colors.grey[800]),),
                      ],
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("${feed.markNumber} Marks", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ,
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeKudosButton(isActive: true),
              makeMarkButton(),
              makeDisappointedButton(isActive: true),
            ],
          )
        ],
      ),
    );
  }

  Widget makeKudos() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)
      ),
      child: const Center(
        child: Icon(Icons.check, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeDisappointed() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)
      ),
      child: const Center(
        child: Icon(Icons.dangerous_outlined, size: 20, color: Colors.white),
      ),
    );
  }

  Widget makeKudosButton({isActive}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 20, top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        onPressed: (){
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, color: isActive ? Colors.blue : Colors.grey, size: 18,),
            const SizedBox(width: 5,),
            Text("Kudos", style: TextStyle(color: isActive ? Colors.blue : Colors.grey),)
          ],
        ),
      ),
    );
  }

  Widget makeDisappointedButton({isActive}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 20, top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.dangerous_outlined, color: isActive ? Colors.red : Colors.grey, size: 18,),
            const SizedBox(width: 5,),
            Text("Diss", style: TextStyle(color: isActive ? Colors.red : Colors.grey),)
          ],
        ),
      ),
    );
  }

  Widget makeMarkButton() {
    return Container(
      width: 100,
      margin: const EdgeInsets.only( top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        onPressed: (){},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.comment, color: Colors.grey, size: 18),
            SizedBox(width: 5,),
            Text("Mark", style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}


