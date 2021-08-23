import 'package:qr_redeem/modelView/Status.dart';

class LoginState {
  String phone;
  String password;
  Status status;

  LoginState({
    required this.phone,
    required this.password,
    required this.status,
  });
}
