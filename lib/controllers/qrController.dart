import 'package:dio/dio.dart';
import 'package:dmjnt_company/models/Qrcode.dart';

class QrController {
  Dio dio = Dio();
  Qrcode qr;
  Future<void> search({String id, Function onSucess}) async {
    try {
      Response response = await dio.get("http://192.168.0.10:4444/dmjnt/search",
          options: Options(headers: {"user_id": id}));
      qr = Qrcode.fromJson(response.data);
      List<Qrs> qrs = qr.qrs;
      onSucess(qrs);
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.data);
      } else {
        print(e.response.data['message']);
      }
    }
  }

  Future<void> create({String id, Function onSucess, Function onFail}) async {
    try {
      Response response = await dio.post(
          "http://192.168.0.10:4444/dmjnt/createqr",
          options: Options(
              headers: {"user_id": id, "date": DateTime.now().toString()}));
        
      onSucess(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        onFail(e.response.data);
      } else {
        onFail(e.response.data);
      }
    }
  }

  Future<void> use({String id, Function onSucess, Function onFail}) async {
    try {
      Response response = await dio.delete("http://192.168.0.10:4444/dmjnt/use",
          options:
              Options(headers: {"id": id, "date": DateTime.now().toString()}));
      print(response.data);
      onSucess(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        onFail(e.response.data);
      } else {
        onFail(e.response.data);
      }
    }
  }

  Future<void> delete(
      {String id, String userid, Function onSucess, Function onFail}) async {
    try {
      Response response = await dio.delete(
          "http://192.168.0.10:4444/dmjnt/delete",
          options: Options(headers: {
            "id": id,
            "user_id": userid,
            "date": DateTime.now().toString()
          }));
      onSucess(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        onFail(e.response.data);
      } else {
        onFail(e.response.data);
      }
    }
  }
}
