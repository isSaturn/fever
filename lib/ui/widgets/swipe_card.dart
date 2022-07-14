import 'package:flutter/material.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/ui/widgets/rounded_icon_button.dart';
import 'package:fever/ui/screens/user_card_screen.dart';
import 'package:fever/util/constants.dart';

import '../../util/colors.dart';

class SwipeCard extends StatefulWidget {
  final AppUser person;

  SwipeCard({@required this.person});

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child:
                Image.network(widget.person.profilePhotoPath, fit: BoxFit.fill),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: getUserContent(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getUserContent(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: size.width * 0.72,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.person.name + ', ',
                      style: TextStyle(
                          color: white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.person.age.toString(),
                      style: TextStyle(
                        color: white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      widget.person.location,
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: white, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          color: white.withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3, bottom: 3, left: 10, right: 10),
                        child: Text(
                          'Khoa: ' + widget.person.majors,
                          style: TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RoundedIconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, UserCard.id);
                });
              },
              iconData: Icons.info,
              iconSize: 16,
              buttonColor: kColorPrimaryVariant,
            ),
          )
        ],
      ),
    );
  }
}
