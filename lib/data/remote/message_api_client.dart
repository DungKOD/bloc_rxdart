import 'package:bloc_rx_dart/models/base_page_model.dart';
import 'package:dio/dio.dart';

class MessageApiClient {
  Dio dio = Dio();

  Future<MessagePage> getMessage(int p) async {
    print("getMessage ....");
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
}
