import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/start_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/util/constants.dart';

import '../widgets/input_dialog.dart';
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
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                  inAsyncCall:
                      userProvider.user == null || userProvider.isLoading,
                  child: userSnapshot.hasData
                      ? Column(
                          children: [
                            getProfileImage(userSnapshot.data, userProvider),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8.0),
                              child: Column(
                                children: [
                                  getName(userSnapshot.data, userProvider),
                                  getGender(userSnapshot.data, userProvider),
                                  getMajors(userSnapshot.data, userProvider),
                                  getBio(userSnapshot.data, userProvider),
                                  getInterests(userSnapshot.data, userProvider),
                                  getLocation(userSnapshot.data, userProvider),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                );
              },
            );
          },
        ),
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
      ],
    );
  }

  Widget getName(AppUser user, UserProvider userProvider) {
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

  Widget getGender(AppUser user, UserProvider userProvider) {
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

  Widget getMajors(AppUser user, UserProvider userProvider) {
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

  Widget getBio(AppUser user, UserProvider userProvider) {
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

  Widget getInterests(AppUser user, UserProvider userProvider) {
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

  Widget getLocation(AppUser user, UserProvider userProvider) {
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
