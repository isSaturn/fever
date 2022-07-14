import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fever/ui/screens/top_navigation_screens/profile_screen.dart';
import 'top_navigation_screens/chats_screen.dart';
import 'top_navigation_screens/match_screen.dart';

class TopNavigationScreen extends StatefulWidget {
  static const String id = 'top_navigation_screen';

  @override
  State<TopNavigationScreen> createState() => _TopNavigationScreenState();
}

class _TopNavigationScreenState extends State<TopNavigationScreen> {
  int pageIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [MatchScreen(), ChatsScreen(), ProfileScreen()],
    );
  }

  Widget getAppBar() {
    List bottomItems = [
      pageIndex == 0
          ? "images/icons/explore_active_icon.svg"
          : "images/icons/explore_icon.svg",
      pageIndex == 1
          ? "images/icons/chat_active_icon.svg"
          : "images/icons/chat_icon.svg",
      pageIndex == 2
          ? "images/icons/account_active_icon.svg"
          : "images/icons/account_icon.svg",
    ];
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(bottomItems.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(
                bottomItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
