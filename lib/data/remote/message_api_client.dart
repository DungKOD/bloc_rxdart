import 'dart:io';

import 'package:bloc_rx_dart/models/base_page_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MessageApiClient {
  Dio dio = Dio();

  Future<MessagePage> getMessage(int p) async {
    Response data =
        await dio.get("https://api.jaemy.net/api/socials/posts?lang=vi&page=$p",
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ));
    MessagePage page = MessagePage.fromJson(data.data);
    return page;
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  downloadFile() async {
    try {
      Response response = await dio.get(
        "https://data.jaemy.net/databases/koen.db.zip",
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);// ???????
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print("download done ....");
    } catch (e) {
      print(e);
    }
  }
}
