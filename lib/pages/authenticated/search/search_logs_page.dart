import 'package:facebook_app/models/search_log_model.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/services/search_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchLogsPage extends StatefulWidget {
  const SearchLogsPage({super.key});

  @override
  State<SearchLogsPage> createState() => _SearchLogsPageState();
}

class _SearchLogsPageState extends State<SearchLogsPage> {
  late ScrollController _scrollController;
  List<SearchLogModel> searchLogs = [];
  bool isLoading = false;
  bool isEnd = false;
  int index = 0;
  static const count = 20;

  void onLoad(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      try {
        final logs = await SearchService(context: context)
            .getRecentKeywords(index: index, count: count);
        if (logs.isEmpty) {
          setState(() {
            isEnd = true;
          });
        } else {
          setState(() {
            searchLogs.addAll(logs);
            index = index + count;
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

  void onDeleteAllLogs() async {
    setState(() {
      isLoading = true;
    });
    try {
      await SearchService(context: context).deleteSearchLog(id: 0, all: 1);
      searchLogs = [];
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
    }

    setState(() {
      isLoading = false;
    });
  }

  void onDeleteLogById(int id) async {
    setState(() {
      isLoading = true;
    });
    try {
      await SearchService(context: context).deleteSearchLog(id: id);
      searchLogs.removeWhere((element) => element.id == id);
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      onLoad(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    onLoad(context);
  }

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                    child: Text(
                  "Lịch sử tìm kiếm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ]),
            ),
            const Divider(
              color: Colors.grey,
            ),
            MyTextButton(
              cbFunction: onDeleteAllLogs,
              title: "Xóa toàn bộ lịch sử tìm kiếm",
              textStyle: const TextStyle(fontSize: 18),
            ),
            searchLogsWidget()
          ]),
        ),
      ),
    );
  }

  Widget searchLogsWidget() {
    return searchLogs.isEmpty
        ? const Text("Không có dữ liệu")
        : Expanded(
            child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        return searchLogItem(searchLogs[index]);
                      },
                      itemCount: searchLogs.length)),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }

  Widget searchLogItem(SearchLogModel log) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        children: [
          const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 28,
              )),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 1,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                log.keyword,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getDifferenceTime(DateTime.now(), DateTime.parse(log.created)),
                style: const TextStyle(
                    color: Color.fromRGBO(30, 30, 30, 0.6), fontSize: 14),
              )
            ]),
          ),
          IconButton(
            icon: const Icon(Icons.close_sharp),
            onPressed: () {
              onDeleteLogById(log.id);
            },
          )
        ],
      ),
    );
  }
}
