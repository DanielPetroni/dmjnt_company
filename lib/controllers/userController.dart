import 'package:dio/dio.dart';
import 'package:dmjnt_company/models/User.dart';

class UserController {
  Dio dio = Dio();
  User user;
  Future<void> login(
      {String numbercard,
      String password,
      Function onFail,
      Function onSucess}) async {
    try {
      Response response = await dio.post("http://192.168.0.10:4444/dmjnt/login",
          data: {"number_card": numbercard, "password": password});
      user = User.fromJson(response.data);
      print(user.balance);
      onSucess(user);
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        onFail(e.response.data['message']);
      } else {
        onFail(e.response.data['message']);
      }
    }
  }

  Future<void> getBalance(
      {String id, Function onFail, Function onSucess}) async {
    print(id);
    try {
      Response response = await dio.get(
          "http://192.168.0.10:4444/dmjnt/getBalance",
          options: Options(headers: {"id": id}));
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

  Future<void> update(
      {String id,
      String password,
      String newPassword,
      Function onFail,
      Function onSucess}) async {
    print('foi');
    try {
      Response response = await dio.put(
        "http://192.168.0.10:4444/dmjnt/update",
        data: {"password": password, "new_password": newPassword},
        options: Options(headers: {"id": id}),
      );
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
