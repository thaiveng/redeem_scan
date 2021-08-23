import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_redeem/event/ScanQrEvent.dart';
import 'package:qr_redeem/models/Product.dart';
import 'package:qr_redeem/service/GiftService.dart';
import 'package:qr_redeem/state/ScanQrState.dart';

class ScanQrBloc extends Bloc<ScanQrEvent, ScanQrState> {
  ScanQrBloc()
      : super(
          ScanQrState(
            false,
            [],
          ),
        );

  GiftService giftService = GiftService();
  @override
  Stream<ScanQrState> mapEventToState(ScanQrEvent event) async* {
    // TODO: implement mapEventToState
    ScanQrState qrSate = ScanQrState(
      state.isCameraGranted,
      state.list,
    );

    if (event is OnAllowed) {
      qrSate.isCameraGranted = true;
      yield qrSate;
    }
    if (event is OnDenied) {
      qrSate.isCameraGranted = false;
      yield qrSate;
    }

    if (event is RequestCameraEvent) {
      PermissionStatus resultCamera = await Permission.camera.request();

      if (resultCamera == PermissionStatus.granted) {
        add(OnAllowed());
      } else {
        add(OnDenied());
      }
    }
    if(event is Confirm){
      giftService.getScan(event.status,event.id);
      print('success');
    }

    if (event is OnSearch) {
      List<Product> product = await giftService.getRedeem();
      add(GetSearch(product));
    }
    if (event is GetSearch) {
      qrSate.list = event.product;
      yield qrSate;
    }
    if (event is ResetStateEvent) {
      yield ScanQrState(
        false,
        [],
      );
    }
  }
}
