import 'package:bloc_rx_dart/data/remote/message_api_client.dart';
import 'package:flutter/cupertino.dart';

class DownloadDB extends StatelessWidget {
  const DownloadDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessageApiClient messageApiClient = MessageApiClient();
    messageApiClient.downloadFile();

    return const Placeholder();
  }
}
