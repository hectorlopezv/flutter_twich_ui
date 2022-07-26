import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:twich_ui_clone/providers/user_provider.dart';
import 'package:twich_ui_clone/screens/feed_screen.dart';
import 'package:twich_ui_clone/screens/go_live_screen.dart';
import 'package:twich_ui_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Text("Browser")
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        unselectedFontSize: 12,
        currentIndex: _page,
        onTap: onPageChange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Following",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: "Go Live",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Browse",
          ),
        ],
      ),
      body: pages[1],
    );
  }
}
