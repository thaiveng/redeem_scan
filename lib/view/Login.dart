import 'package:flutter/material.dart';
import 'package:qr_redeem/bloc/LoginBloc.dart';
import 'package:qr_redeem/event/LoginEvent.dart';
import 'package:qr_redeem/state/LoginState.dart';
import 'package:qr_redeem/util/FormValidation.dart';
import 'package:qr_redeem/widget/LinearProgress.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String phone = "";
  String password = "";
  bool obscure = true;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(context),
      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
            print('${state.status.code}');
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                ListView(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Form(
                            key: _loginFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Staff Login",
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 18),
                                TextFormField(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  keyboardType: TextInputType.emailAddress,
                                  initialValue: phone,
                                  validator: validationPhoneNumber,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number/Username",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                ),
                                SizedBox(height: 18),
                                TextFormField(
                                  validator: validatePassword,
                                  obscureText: obscure,
                                  initialValue: password,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        obscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          obscure = !obscure;
                                        });
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    password = value;
                                  },
                                ),
                                error != ""
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 3),
                                        child: Text(
                                          error,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 22),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFFb307f1)),
                                      ),
                                      onPressed: () async {
                                        if (_loginFormKey.currentState!
                                            .validate()) {
                                          print('clicked');
                                          context.read<LoginBloc>().add(
                                                SignInEvent(
                                                    context, phone, password),
                                              );
                                        }
                                      },
                                      child: Text(
                                        "Login Now",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                LinearProgress(state.status),
              ],
            ),
          ),
        );
      }),
    );
  }
}
