import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_redeem/bloc/RedeemBloc.dart';
import 'package:qr_redeem/state/RedeemState.dart';

class RedeemList extends StatefulWidget {
  const RedeemList({Key? key}) : super(key: key);

  @override
  _RedeemListState createState() => _RedeemListState();
}

class _RedeemListState extends State<RedeemList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RedeemBloc, RedeemState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Available redeem gift",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: 100,
                        child:
                            Image.network("${state.list[index].item?.image}"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${state.list[0].item?.itemName}",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              "${state.list[0].item?.itemCode}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${state.list[0].status}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                // title: Text("${state.list[0].item?.itemName}"),
                // leading: Image.network("${state.list[0].item?.image}",height: 600,),
              ),
            )
          ],
        );
      },
    );
  }
}
