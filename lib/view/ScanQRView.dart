import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:qr_redeem/bloc/ScanQrBloc.dart';
import 'package:qr_redeem/event/ScanQrEvent.dart';
import 'package:qr_redeem/state/ScanQrState.dart';
import 'package:qr_redeem/util/ResumeState.dart';

class ScanQRView extends StatefulWidget {
  @override
  _ScanQRViewState createState() => _ScanQRViewState();
}

class _ScanQRViewState extends ResumeState<ScanQRView>
    with TickerProviderStateMixin {
  late AnimationController productController;
  late AnimationController painterScannerController;
  late QrReaderViewController cameraController;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    productController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(productController);
    painterScannerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    painterScannerController.repeat(reverse: true);
    context.read<ScanQrBloc>().add(RequestCameraEvent());
  }

  @override
  void onResume() {
    // TODO: implement onResume
    //cameraController?.startCamera(onScan);
    super.onResume();
  }

  @override
  void onPause() {
    // TODO: implement onPause
    // painterScannerController?.stop();
    cameraController.stopCamera();
    super.onPause();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanQrBloc, ScanQrState>(
      listener: (BuildContext context, ScanQrState state) {
        if (state.list.length > 0) {
          productController.forward();
          painterScannerController.stop();
        }
      },
      builder: (BuildContext context, ScanQrState state) {
        return Scaffold(
          body: Container(
            child: Stack(
              children: [
                if (state.isCameraGranted)
                  AnimatedBuilder(
                    builder: (BuildContext context, Widget? child) {
                      return CustomPaint(
                        foregroundPainter: _ScanPainter(
                          painterScannerController.value,
                          Colors.white,
                          Colors.green,
                        ),
                        child: QrReaderView(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          callback: (container) {
                            cameraController = container;
                            cameraController.startCamera(onScan);
                          },
                        ),
                        willChange: true,
                      );
                    },
                    animation: painterScannerController,
                  )
                else
                  Container(
                    child: Center(child: Text("No Permission")),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: offset,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: productCard(productController, state)),
                    // child: Center(
                    //   child:Text('search')
                    // ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget productCard(Animation<double> opacityAnimation, ScanQrState state) {
    if (state.list.length == 0) {
      return Container();
    }
    return Card(
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      painterScannerController.repeat(reverse: true);
                      cameraController.startCamera(onScan);
                      productController.reverse();
                    })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 16),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${state.list[0].item?.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${state.list[0].item?.itemName}",
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${state.list[0].item?.itemCode}",
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${state.list[0].status}",
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFFFFFFF)),
                            ),
                            onPressed: () {
                              painterScannerController.repeat(reverse: true);
                              cameraController.startCamera(onScan);
                              productController.reverse();
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFb307f1)),
                            ),
                            onPressed: () {
                              context
                                  .read<ScanQrBloc>()
                                  .add(Confirm("available", "${state.list[0].id}"));
                            },
                            child: Text(
                              "Confirm",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onScan(String v, List<Offset> offsets) {
    print("onScan::${[v, offsets]}");
    painterScannerController.stop();
    cameraController.stopCamera();
    context.read<ScanQrBloc>().add(OnSearch(v, context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    painterScannerController.dispose();
    productController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    painterScannerController.dispose();
    productController.dispose();
    cameraController.stopCamera();
    context.read<ScanQrBloc>().add(ResetStateEvent());
    super.deactivate();
  }
}

class _ScanPainter extends CustomPainter {
  final double value;
  final Color borderColor;
  final Color scanColor;

  _ScanPainter(this.value, this.borderColor, this.scanColor);

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      initPaint();
    }
    double width = size.width;
    // double height = size.height;

    double boxWidth = width * 2 / 3;
    double boxHeight = width * 2 / 3;

    double left = (width - boxWidth) / 2;
    double top = boxHeight / 2;
    double bottom = boxHeight * 3 / 2;
    double right = left + boxWidth;
    _paint.color = borderColor;
    final rect = Rect.fromLTWH(left, top, boxWidth, boxHeight);
    canvas.drawRect(rect, _paint);

    _paint.strokeWidth = 3;

    Path path1 = Path()
      ..moveTo(left, top + 10)
      ..lineTo(left, top)
      ..lineTo(left + 10, top);
    canvas.drawPath(path1, _paint);
    Path path2 = Path()
      ..moveTo(left, bottom - 10)
      ..lineTo(left, bottom)
      ..lineTo(left + 10, bottom);
    canvas.drawPath(path2, _paint);
    Path path3 = Path()
      ..moveTo(right, bottom - 10)
      ..lineTo(right, bottom)
      ..lineTo(right - 10, bottom);
    canvas.drawPath(path3, _paint);
    Path path4 = Path()
      ..moveTo(right, top + 10)
      ..lineTo(right, top)
      ..lineTo(right - 10, top);
    canvas.drawPath(path4, _paint);

    _paint.color = scanColor;

    final scanRect = Rect.fromLTWH(
        left + 10, top + 10 + (value * (boxHeight - 20)), boxWidth - 20, 3);

    _paint.shader = LinearGradient(colors: <Color>[
      Colors.white54,
      Colors.white,
      Colors.white54,
    ], stops: [
      0.0,
      0.5,
      1,
    ]).createShader(scanRect);
    canvas.drawRect(scanRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void initPaint() {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }
}
