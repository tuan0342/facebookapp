import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend/friend_block_item.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BlockPage extends StatefulWidget {
  const BlockPage({super.key});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppService appService = Provider.of<AppService>(context, listen: false);
  late ScrollController _scrollController;
  List<FriendBlock> friendBlock = [];
  bool isLoading = false;
  bool isEnd = false;
  int index = 0;
  static const count = 20;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    onLoad(context);
  }

  void onLoad(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      final data =
          await FriendService(context: context).getBlocksList(index, count, appService.uidLoggedIn);

      if (data.isEmpty) {
        setState(() {
          isEnd = true;
        });
      } else {
        setState(() {
          friendBlock.addAll(data);
          index = index + count;
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      onLoad(context);
    }
  }

  Future refresh() async {
    setState(() {
      friendBlock = [];
      isLoading = false;
      isEnd = false;
      index = 0;
    });
    onLoad(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Danh sách bạn bè bị chặn"),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: refresh,
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người bị chặn', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 10,),
                    const Text('Một khi bạn chặn ai đó, họ sẽ không thể xem được nội dung bạn tự đăng trên dòng thời gian của mình, gắn thẻ bạn bè, mời bạn tham gia các sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm làm bạn bè. Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn và người này đều tham gia.', style: TextStyle(fontSize: 14, height: 1.2, color: Colors.black54),),
                    const SizedBox(height: 20,),

                    Container(
                      padding: EdgeInsets.zero,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: (){
                          context.push('/authenticated/menu/setting/block/addBlock')
                            .then((value) => refresh());
                        }, 
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child:  Icon(
                                Icons.add_box,
                                color: Colors.blue[600],
                                size: 50,
                              ),
                            ),
                            Text('THÊM VÀO DANH SÁCH CHẶN', style: TextStyle(color: Colors.blue[400], fontSize: 16.0),),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),

                    blocksList(),

                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          ),
        )
      )
      );
  }

  Widget blocksList() {
    return friendBlock.isEmpty
        ? const Center(child: Text("Danh sách rỗng"))
        : SizedBox(
            child: Column(children: [ 
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: friendBlock.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: FriendBlockItem(
                    friend: friendBlock[index],
                    refreshBlock: refresh,
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator(),
            ],)
          );
  }
}