import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/ui/widgets/user_image.dart';

import '../../data/provider/user_provider.dart';
import '../../util/colors.dart';
import '../../util/constants.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getProfileImage(widget.person),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: Column(
                children: [
                  getName(widget.person),
                  getGender(widget.person),
                  getMajors(widget.person),
                  getBio(widget.person),
                  getInterests(widget.person),
                  getLocation(widget.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getProfileImage(
    AppUser user,
  ) {
    return Column(
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
      ],
    );
  }

  Widget getName(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tên: ', style: Theme.of(context).textTheme.headline4),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user?.name.length != 0 ? user.name : "No info.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget getGender(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Giới tính: ', style: Theme.of(context).textTheme.headline4),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user?.gender.length != 0 ? user.gender : "No info.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget getMajors(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ngành học: ', style: Theme.of(context).textTheme.headline4),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user?.majors.length != 0 ? user.majors : "No info.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget getBio(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bio: ', style: Theme.of(context).textTheme.headline4),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user?.bio.length != 0 ? user.bio : "No info.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget getInterests(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Sở thích',
          style: Theme.of(context).textTheme.headline4,
        ),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 5,
              mainAxisSpacing: 10,
            ),
            itemCount: user.interests.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, index) {
              return Center(
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: kAccentColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(user.interests[index])),
              );
            }),
      ],
    );
  }

  Widget getLocation(
    AppUser user,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Vị trí: ', style: Theme.of(context).textTheme.headline4),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user?.state.length != 0 ? user.state : "No info.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
