import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_redeem/bloc/ScanQrBloc.dart';
import 'package:qr_redeem/bloc/RedeemBloc.dart';
import 'package:qr_redeem/view/ScanQRView.dart';
import 'package:qr_redeem/view/RedeemList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;
  int oldPageIndex = 0;
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back!"),
        backgroundColor: Color(0xFFb307f1),
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFb307f1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Redeem List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_overscan),
            label: 'Scan To Redeem',
          ),
        ],
        currentIndex: bottomSelectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: bottomTapped,
      ),
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[

        BlocProvider<RedeemBloc>(
          create: (context) {
            return RedeemBloc();
          },
          child:  RedeemList(),
        ),

        BlocProvider<ScanQrBloc>(
          create: (context) {
            return ScanQrBloc();
          },
          child: ScanQRView(),
        ),
      ],
      physics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
