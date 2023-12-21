import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/friend/search_friend_box.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/my_widgets/post/list_post.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/search_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final formKey = Key
  late ScrollController _scrollController;
  late FocusNode _focus;
  final TextEditingController _keywordController = TextEditingController();
  late int index;
  static const int count = 10;
  bool isEnd = false;
  bool isLoading = false;
  bool isPost = true;

  List<SuggestFriendModel>? users;
  bool isLoadingUsers = false;
  bool isEndUsers = false;
  int indexUsers = 0;

  late List<String> keywords = [];
  List<Post>? result;
  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      isPost ? onSearch(context) : onSearchUser(context);
    }
  }

  void onSearch(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      try {
        final posts = await SearchService(context: context)
            .search(_keywordController.text, index, count);
        if (posts.isEmpty) {
          setState(() {
            result = result ?? posts;
            isEnd = true;
          });
        } else {
          setState(() {
            if (result == null) {
              result = posts;
              index = count;
            } else {
              result!.addAll(posts);
              index = index + count;
            }
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void onSearchUser(BuildContext context) async {
    debugPrint('bcd users: ${isEndUsers}');
    if (!isEndUsers) {
      setState(() {
        isLoadingUsers = true;
      });
      try {
        final usersResponse = await SearchService(context: context)
            .searchUser(_keywordController.text, indexUsers, count);
        debugPrint('bcd users data: ${usersResponse.length}');
        if (usersResponse.isEmpty) {
          setState(() {
            users = users ?? usersResponse;
            isEndUsers = true;
          });
        } else {
          setState(() {
            if (users == null) {
              users = usersResponse;
              indexUsers = count;
            } else {
              users!.addAll(usersResponse);
              indexUsers = indexUsers + count;
            }
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setState(() {
          isLoadingUsers = false;
        });
      }
    }
  }

  Future refresh() async {
    setState(() {
      isLoadingUsers = false;
      isEndUsers = false;
      indexUsers = 0;
      users = null;
    });
    onSearchUser(context);
  }

  void onShowSearchLogs(BuildContext context) {
    context.push("/authenticated/search/logs");
  }

  void initKeyWords(BuildContext context) async {
    final listKeywords = await SearchService(context: context)
        .getRecentKeywords(index: 0, count: 100, inSearchPage: true);
    Set<String> set = {};
    for (var element in listKeywords) {
      set.add(element.keyword.trim());
    }
    setState(() {
      keywords = set.take(20).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _focus = FocusNode();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        initKeyWords(context);
        setState(() {
          result = null;
          users = null;
          index = 0;
          indexUsers = 0;
          isEnd = false;
          isEndUsers = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: _focus,
                    controller: _keywordController,
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        showSnackBar(
                            context: context,
                            msg: "Vui lòng nhập từ khóa để tìm kiếm",
                            timeShow: 2000);
                      } else {
                        // save keyword
                        final temp = keywords;
                        temp.add(_keywordController.text);
                        appService.sharedPreferences.setStringList(
                            "KEYWORDS_${appService.uidLoggedIn}", temp);
                        // search
                        isPost ? onSearch(context) : onSearchUser(context);
                      }
                    },
                    cursorColor: Colors.black,
                    autofocus: true,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm",
                      suffixIcon: IconButton(
                          onPressed: () {
                            _keywordController.clear();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey[500],
                          )),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                              style: BorderStyle.none)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                              style: BorderStyle.none)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                              style: BorderStyle.none)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isPost = true;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.question_answer,
                                      size: 32,
                                      color:
                                          isPost ? Colors.blue : Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Bài viết",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: isPost
                                              ? Colors.blue
                                              : Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isPost = false;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 32,
                                      color:
                                          isPost ? Colors.black : Colors.blue,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Người dùng",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: isPost
                                              ? Colors.black
                                              : Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ]),
            ),
            const Divider(
              color: Colors.grey,
            ),
            // _focus.hasFocus || result == null
            //     ? recentSearches()
            //     : showResult(),
            isPost
                ? _focus.hasFocus || result == null
                    ? recentSearches()
                    : showPostResult()
                : _focus.hasFocus || users == null
                    ? recentSearches()
                    : showUserResult(),
          ]),
        ),
      ),
    );
  }

  // Widget show kết quả tìm kiếm
  Widget showPostResult() {
    return ListPost(
        posts: result!,
        scrollController: _scrollController,
        isLoading: isLoading);
  }

  Widget showUserResult() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, bottom: 25, top: 10),
          child: Text(
            "Mọi người",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: users!.length,
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child:
                    SearchFriendBox(friend: users![index], refresh: refresh)),
          ),
        ),
        if (isLoading) const CircularProgressIndicator()
      ],
    ));
  }

  // Widget show tìm kiếm gần đây
  Widget recentSearches() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: const Text(
                  "Tìm kiếm gần đây",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                MyTextButton(
                  cbFunction: () {
                    onShowSearchLogs(context);
                  },
                  title: "Chỉnh sửa",
                  textStyle: const TextStyle(fontSize: 20),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
                child: ListView(
              children: keywords.map((e) => recentSearchesItem(e)).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget recentSearchesItem(String keyword) {
    return TextButton(
      onPressed: () {
        handleTapRecentSearchItem(keyword);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 28,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              keyword,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  void handleTapRecentSearchItem(String keyword) async {
    _keywordController.text = keyword;
  }
}
