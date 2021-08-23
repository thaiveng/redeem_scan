
import 'package:flutter/material.dart';
import 'package:qr_redeem/models/Product.dart';

class ScanQrEvent {}

class OnAllowed extends ScanQrEvent {}

class OnDenied extends ScanQrEvent {}

class RequestCameraEvent extends ScanQrEvent {}

class OnSearch extends ScanQrEvent {
  final String search;
  final BuildContext context;
  OnSearch(this.search,this.context);
}

class ChooseImage extends ScanQrEvent {
  BuildContext context;
  ChooseImage(this.context);
}
class Confirm extends ScanQrEvent{
  String status;
  String id;

  Confirm(this.status,this.id);
}
class GetSearch extends ScanQrEvent {
  final List<Product> product;

  GetSearch(this.product);
}

class ResetStateEvent extends ScanQrEvent {
}
