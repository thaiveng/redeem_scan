import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_redeem/event/LoginEvent.dart';
import 'package:qr_redeem/modelView/Status.dart';
import 'package:qr_redeem/service/AuthService.dart';
import 'package:qr_redeem/state/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  BuildContext context;
  AuthService authService = AuthService();

  LoginBloc(this.context)
      : super(LoginState(status: new Status(0), password: '', phone: ''));

  @override
  Stream<LoginState> mapEventToState(event) async* {
    LoginState loginState = new LoginState(
      phone: state.phone,
      password: state.password,
      status: state.status,
    );

    if (event is UpdateStatusEvent) {
      loginState.status = event.status;
      yield loginState;
    }
    if (event is SignInEvent) {
      print('sign in event');
      loginState.status = Status(-1);
      yield loginState;
      loginState.status = await authService.logIn(event.phone, event.password);
      if (loginState.status.code == 1) {
        Navigator.of(event.context).pushNamed("/homepage", arguments: {
          "user": state.status.fullMessage,
          "password": event.password
        });
      }
      add(UpdateStatusEvent(Status(0)));
      if (loginState.status.code == 0) {
        loginState.status.message = "Login";
        // showSnackBar(event.context,state.status);
      }
    }
  }
}
