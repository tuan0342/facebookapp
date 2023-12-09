import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/my_widgets/post/feed_item.dart';
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

  late List<String> keywords = [];
  List<Post>? result;
  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      onSearch(context);
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

  void onShowSearchLogs(BuildContext context) {
    context.push("/authenticated/search/logs");
  }

  void initKeyWords(BuildContext context) async {
    final listKeywords = await SearchService(context: context)
        .getRecentKeywords(index: 0, count: 100, inSearchPage: true);
    Set<String> set = {};
    listKeywords.forEach((element) {
      set.add(element.keyword.trim());
    });
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
          index = 0;
          isEnd = false;
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
    final _appService = Provider.of<AppService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        _appService.sharedPreferences.setStringList(
                            "KEYWORDS_${_appService.uidLoggedIn}", temp);
                        // search
                        onSearch(context);
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
              ]),
            ),
            const Divider(
              color: Colors.grey,
            ),
            _focus.hasFocus || result == null
                ? recentSearches()
                : ListPost(posts: result!, scrollController: _scrollController, isLoading: isLoading),
          ]),
        ),
      ),
    );
  }

  // Widget show tìm kiếm gần đây
  Widget recentSearches() {
    return Expanded(
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
