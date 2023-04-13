import 'dart:io';

import 'package:bloc_rx_dart/blocs/base_bloc.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import '../data/remote/message_api_client.dart';
import '../models/base_page_model.dart';

class MessageListBloc extends BaseBloc {
  final _api = MessageApiClient();

  var messagesListPublishSubject = PublishSubject<List<Data>?>();
  var page = 0;
  List<Data> listData = <Data>[];

  getListMessagesListIntoBloc() async {
    page++;
    if (page == 1) {
      print("null...");
      messagesListPublishSubject.sink.add(null);
    }
    var response = await _api.getMessage(page);
    if (response != null) {
      if (response.data != null || response.data.isNotEmpty) {
        listData.addAll(response.data);
        messagesListPublishSubject.sink.add(listData);
      } else {
        messagesListPublishSubject.sink.add(List.empty());
      }
    } else {
      messagesListPublishSubject.sink.add(List.empty());
    }
  }

  downloadFile() async {
    _api.downloadFile();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final zipFile = File("zip_file_path");
    final destinationDir = Directory(
        "/data/data/${packageInfo.packageName}/databases/koen.db.zip");
    try {
      ZipFile.extractToDirectory(
          zipFile: zipFile, destinationDir: destinationDir);
      print("zip file successfully");
    } catch (e) {
      print("error --- $e");
    }
  }

  @override
  dispose() {
    messagesListPublishSubject.close();
  }
}
