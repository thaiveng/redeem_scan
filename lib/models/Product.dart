import 'package:qr_redeem/models/Item.dart';

class Product {
  String? id;
  String? redeemCode;
  String? status;
  int? timestamp;
  Item? item;

  Product({this.id, this.redeemCode, this.status, this.timestamp, this.item});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    redeemCode = json['redeemCode'];
    status = json['status'];
    timestamp = json['timestamp'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['redeemCode'] = this.redeemCode;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    if (this.item != null) {
      data['item'] = this.item?.toJson();
    }
    return data;
  }
}
