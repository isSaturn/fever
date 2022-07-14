import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/start_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/util/constants.dart';

import '../widgets/rounded_icon_button.dart';
import '../widgets/user_image.dart';

class MyProfileUserCard extends StatefulWidget {
  static const String id = 'my_profile_user_card_screen';

  @override
  _MyProfileUserCardState createState() => _MyProfileUserCardState();
}

class _MyProfileUserCardState extends State<MyProfileUserCard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void logoutPressed(UserProvider userProvider, BuildContext context) async {
    userProvider.logoutUser();
    Navigator.pop(context);
    Navigator.pushNamed(context, StartScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return FutureBuilder<AppUser>(
            future: userProvider.user,
            builder: (context, userSnapshot) {
              return CustomModalProgressHUD(
                inAsyncCall:
                    userProvider.user == null || userProvider.isLoading,
                child: userSnapshot.hasData
                    ? Wrap(
                        children: [
                          getProfileImage(userSnapshot.data, userProvider),
                        ],
                      )
                    : Container(),
              );
            },
          );
        },
      ),
    );
  }

  Widget getProfileImage(AppUser user, UserProvider firebaseProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.9,
          child: Hero(
            tag: 'user_card',
            child: UserImage.medium(
              url: user.profilePhotoPath,
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              Text(
                '${user.bio}',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              Text(
                '${user.majors}',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              Text(
                '${user.location}',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
