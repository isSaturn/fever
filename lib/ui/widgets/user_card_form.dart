import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/ui/widgets/user_image.dart';

import '../../util/colors.dart';
import 'rounded_icon_button.dart';

class UserCardForm extends StatefulWidget {
  final AppUser person;

  UserCardForm({@required this.person});

  @override
  _UserCardFormState createState() => _UserCardFormState();
}

class _UserCardFormState extends State<UserCardForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: Stack(
              children: [
                Hero(
                  tag: 'user_card',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: UserImage.medium(
                      url: widget.person.profilePhotoPath,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 60,
                    ),
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.person.name}',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${widget.person.majors}',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${widget.person.location}',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${widget.person.bio}',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
