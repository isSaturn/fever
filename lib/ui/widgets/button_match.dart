import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fever/util/colors.dart';

class ButtonMatch extends StatefulWidget {
  @override
  State<ButtonMatch> createState() => _ButtonMatchState();
}

class _ButtonMatchState extends State<ButtonMatch> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 128,
      decoration: BoxDecoration(color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 58.0,
            height: 58.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white,
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  // changes position of shadow
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Center(
                child: SvgPicture.asset(
                  'images/icons/close_icon.svg',
                  width: 25.0,
                ),
              ),
            ),
          ),
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white,
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  // changes position of shadow
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Center(
                child: SvgPicture.asset(
                  'images/icons/like_icon.svg',
                  width: 30.0,
                ),
              ),
            ),
          ),
          Container(
            width: 58.0,
            height: 58.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white,
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  // changes position of shadow
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Center(
                child: SvgPicture.asset(
                  'images/icons/thunder_icon.svg',
                  width: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // Expanded(
    //   child: Container(
    //     margin: EdgeInsets.symmetric(
    //         horizontal: 45),
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: Row(
    //         mainAxisAlignment:
    //             MainAxisAlignment
    //                 .spaceBetween,
    //         children: [
    //           RoundedIconButton(
    //             onPressed: () {
    //               personSwiped(
    //                   userSnapshot.data,
    //                   snapshot.data,
    //                   false);
    //             },
    //             iconData: Icons.clear,
    //             buttonColor: Colors.red,
    //             iconSize: 30,
    //           ),
    //           RoundedIconButton(
    //             onPressed: () {
    //               personSwiped(
    //                   userSnapshot.data,
    //                   snapshot.data,
    //                   true);
    //             },
    //             iconData: Icons.favorite,
    //             iconSize: 40,
    //           ),
    //           RoundedIconButton(
    //             onPressed: () {},
    //             iconData: Icons.star,
    //             buttonColor: Colors.blue,
    //             iconSize: 30,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
  }
}
