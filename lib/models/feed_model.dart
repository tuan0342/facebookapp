
class Feed{
  final String feedId;
  final String userName;
  final String userImage;
  final String feedTime;
  final String feedContent;
  final List<String> feedImageList;
  final String feedVideo;
  int kudosNumber;
  int disappointedNumber;
  int markNumber;

  Feed(this.userImage, this.feedTime, this.feedContent, this.feedImageList, this.feedVideo,
      this.kudosNumber, this.disappointedNumber, this.markNumber, this.feedId, this.userName);


  Feed.fromJson(Map<String, dynamic> json)
      : feedId = json['id'],
        userImage = json['userImage'],
        feedTime = json['feedTime'],
        feedContent = json['feedContent'],
        feedImageList = json['feedImageList'],
        feedVideo = json['feedVideo'],
        kudosNumber = json['kudosNumber'],
        disappointedNumber = json['disappointedNumber'],
        markNumber = json['markNumber'],
        userName =json['userName'];

  Map<String, dynamic> toJson() {
    return {
    "feedId": feedId,
    "userImage": userImage,
    "feedTime": feedTime,
    "feedContent": feedContent,
    "feedImageList": feedImageList,
    "feedVideo": feedVideo,
    "kudosNumber": kudosNumber,
    "disappointedNumber": disappointedNumber,
    "markNumber": markNumber,
    "userName": userName,
  };
  }

}