import 'package:dio/dio.dart' as D;
import 'package:qr_redeem/models/Product.dart';
import 'package:qr_redeem/util/AppApiEndpoint.dart';
import 'package:qr_redeem/util/HttpStatusCode.dart';

class GiftService{
  Future<List<Product>> getRedeem() async {
    List<Product> list = [];
    try {
      String url = AppApiEndpoint.MainUrl + AppApiEndpoint.REDEEM;
      print('gift :: $url');
      D.Response response = await D.Dio().get(url);
      if (response.statusCode != HttpStatusCode.SUCCESS) {
        return list;
      }
      Iterable data = response.data;
      print('data :: $data');
      list = data.map((news) => Product.fromJson(news)).toList();
      print('result :: ${list.length}');
      return list;
    } catch (e) {
      print('error $e');
      return list;
    }
  }
   void getScan(String status,String id) async {
    String url = AppApiEndpoint.MainUrl + AppApiEndpoint.REDEEM+id;
    try {
      print('gift :: $url');
      await D.Dio().patch(url,data: {
        "status" : status
      });
    } catch (e) {
      print('error $e');
    }
  }
}