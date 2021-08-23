import 'package:flutter/material.dart';
import 'package:qr_redeem/modelView/Status.dart';
class LinearProgress extends StatelessWidget {
  final Status status;

  LinearProgress(this.status);

  @override
  Widget build(BuildContext context) {
    if(status.code! >= 0) return Container();
    return SizedBox(
      height: 4,
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
      ),
    );
  }
}
