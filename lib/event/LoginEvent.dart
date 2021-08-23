
import 'package:flutter/material.dart';
import 'package:qr_redeem/modelView/Status.dart';

abstract class LoginEvent {
}
class SignInEvent extends LoginEvent{
  String phone;
  String password;
  BuildContext context;
  SignInEvent(this.context,this.phone, this.password);

}
class UpdateStatusEvent extends LoginEvent{
  Status status;
  UpdateStatusEvent(this.status);
}




