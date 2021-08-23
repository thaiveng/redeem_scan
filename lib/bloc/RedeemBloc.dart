import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_redeem/event/RedeemEvent.dart';
import 'package:qr_redeem/service/GiftService.dart';
import 'package:qr_redeem/state/RedeemState.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  RedeemBloc() : super(RedeemState([])){
    add(LoadData());
  }
  GiftService giftService = GiftService();
  @override
  Stream<RedeemState> mapEventToState(RedeemEvent event) async* {
    RedeemState redeemState = RedeemState(
      state.list
    );
    // TODO: implement mapEventToState
    if(event is LoadData){
      redeemState.list = await giftService.getRedeem();
      yield redeemState;
    }
  }
}
