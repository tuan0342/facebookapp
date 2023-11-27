import 'package:facebook_app/models/feed_model.dart';

class FeedService {
  List<Feed> feeds = [
    Feed('assets/images/img.png', '10:00', 'heelo', ['assets/images/img.png'],
        '', 2, 2, 4, '1', 'loi vu'),
    Feed('assets/images/img.png', '10:00', 'heelo', ['assets/images/img.png'],
        '', 2, 2, 4, '1', 'loi vu'),
    Feed('assets/images/img.png', '10:00', 'heelo', ['assets/images/img.png'],
        '', 2, 2, 4, '1', 'loi vu'),
    Feed('assets/images/img.png', '10:00', 'heelo', ['assets/images/img.png'],
        '', 2, 2, 4, '1', 'loi vu')
  ];

  Future<List<Feed>> getFeeds() async {
    return Future.value(feeds);
  }

  bool updateFeed(int index) {
    feeds[index].disappointedNumber +=1;
    feeds[index].kudosNumber += 1;
    return true;
  }
}
