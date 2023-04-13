import 'package:bloc_rx_dart/models/base_page_model.dart';
import 'package:flutter/material.dart';
import '../blocs/message_list_bloc.dart';
import '../extensions/Date.dart';
import 'package:flutter_html/flutter_html.dart';

class ListMessageView extends StatefulWidget {
  const ListMessageView({Key? key}) : super(key: key);

  @override
  State<ListMessageView> createState() => _ListMessageViewState();
}

class _ListMessageViewState extends State<ListMessageView> {
  var bloc = MessageListBloc();

  @override
  void initState() {
    super.initState();
    bloc.getListMessagesListIntoBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Data>?>(
        stream: bloc.messagesListPublishSubject.stream,
        builder: (context, snapshot) {
          print("snapshot  ${snapshot.data}");
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print("index $index    --- ${snapshot.data!.length}");
                  if (index == snapshot.data!.length - 1) {
                    bloc.getListMessagesListIntoBloc();
                    print("index $index");
                    return Container(
                      width: 40,
                      height: 40,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    Data data = snapshot.data![index];
                    return _itemPost(data);
                  }
                });
          } else {
            return const Center(
              child: Text("data empty"),
            );
          }
        });
  }

  Widget _itemPost(Data data) {
    RegExp exp = RegExp(r'<h1>(.*?)<\/h1>');
    Iterable<Match> matches = exp.allMatches(data.body.toString());
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400])),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    if (data.author!.image.toString().startsWith("https://") ||
                        data.author!.image.toString().startsWith("http://"))
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage(data.author!.image.toString()),
                        onBackgroundImageError: (_, h) {
                          const AssetImage('assets/images/doremon.png');
                        },
                      )
                    else
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/doremon.png'),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              data.author!.username.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "${data.author!.label}   *${MyDateUtils.dateFormat(data.createdAt!)}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                Expanded(
                                  child: Text(
                                    "  *${data.category!.name}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: (matches.isNotEmpty)
                      ? Html(data: data.body.toString())
                      : Html(data: data.body.toString())),
              const Divider(height: 1, color: Colors.grey),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Like ${data.votes!.toString()}",
                          style: const TextStyle(
                              color: Colors.grey, letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => {print("printing")},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mode_comment_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Comment ${data.totalComment!.toString()}",
                            style: const TextStyle(
                                color: Colors.grey, letterSpacing: 1))
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share_sharp,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("follows ${data.follows!.toString()}",
                            style: const TextStyle(
                                color: Colors.grey, letterSpacing: 1))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
