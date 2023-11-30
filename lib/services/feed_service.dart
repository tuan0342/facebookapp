import 'package:facebook_app/models/image_model.dart';
import 'package:facebook_app/models/post_model.dart';

class FeedService {
  List<Post> posts = [
    Post(
        id: 1,
        name: "",
        image: [Image(id: 1, url: "assets/images/img")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 10,
        markComment: 0,
        isFelt: 1,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: "https://it4788.catan.io.vn/files/avatar-1700472905228-894880239.jpg")),
    Post(
        id: 1,
        name: "",
        image: [Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 8,
        markComment: 0,
        isFelt: 1,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: "")),
    Post(
        id: 1,
        name: "",
        image: [Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 20,
        markComment: 0,
        isFelt: 0,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: "")),
    Post(
        id: 1,
        name: "",
        image: [Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 0,
        markComment: 0,
        isFelt: 0,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: "")),
  ];

  Future<List<Post>> getFeeds() async {
    return Future.value(posts);
  }

  bool updateFeed(int index) {
    // posts[index].disappointedNumber +=1;
    // posts[index].kudosNumber += 1;
    return true;
  }
}
