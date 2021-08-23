import 'dart:convert';
import 'package:dio/dio.dart' as D;
import 'package:qr_redeem/modelView/Status.dart';
import 'package:qr_redeem/models/UserModel.dart';
import 'package:qr_redeem/util/AppApiEndpoint.dart';
import 'package:qr_redeem/util/AppUtils.dart';
import 'package:qr_redeem/util/HttpStatusCode.dart';
import 'package:qr_redeem/util/StorageUtils.dart';

class AuthService {
  Future<Status> logIn(String phone, String password) async {
    String url = AppApiEndpoint.MainUrl + AppApiEndpoint.LOGIN;
    print('$phone $password');
    try {
      D.Response response = await D.Dio().post(url, data: {
        "username": phone,
        "password": password,
      });
      print("response ${response.statusCode}");
      print("response ${response.data}");
      UserModel userModel = UserModel.fromJson(response.data);
      await StorageUtils()
          .setStringGetStorage(AppUtils.USER, jsonEncode(userModel.toJson()));
      if (response.statusCode != HttpStatusCode.SUCCESS) {
        return Status(0);
      }
      return Status(1);
    } catch (e) {
      print('error :$e');
      return Status(0, fullMessage: e.toString());
    }
  }
}
