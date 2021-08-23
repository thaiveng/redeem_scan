import 'package:qr_redeem/models/Product.dart';

class ScanQrState{
  bool isCameraGranted;
  List<Product> list;
  ScanQrState(this.isCameraGranted,this.list);
}