import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/edit_screen.dart';
import 'package:fever/ui/screens/my_profile_user_card.dart';
import 'package:fever/ui/screens/start_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/util/constants.dart';
import '../settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void logoutPressed(UserProvider userProvider, BuildContext context) async {
    userProvider.logoutUser();
    Navigator.pop(context);
    Navigator.pushNamed(context, StartScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 42.0,
          horizontal: 18.0,
        ),
        margin: EdgeInsets.only(bottom: 40),
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
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, MyProfileUserCard.id),
                              child: getProfileImage(
                                  userSnapshot.data, userProvider),
                            ),
                            SizedBox(height: 20),
                            Text(
                                '${userSnapshot.data.name}, ${userSnapshot.data.age}',
                                style: Theme.of(context).textTheme.headline4),
                            SizedBox(height: 40),
                            getSettings(userSnapshot.data, userProvider),
                            Expanded(
                              child: Container(),
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

  Widget getSettings(AppUser user, UserProvider firebaseProvider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, SettingsScreen.id),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 10,
                        blurRadius: 15,
                        // changes position of shadow
                      ),
                    ]),
                child: Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.grey.withOpacity(1),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "SETTINGS",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.withOpacity(0.8),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                width: 85,
                height: 85,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          firebaseProvider.updateUserProfilePhoto(
                              pickedFile.path, _scaffoldKey);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFfc3973),
                                Color(0xFFfd5f60),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 15,
                                // changes position of shadow
                              ),
                            ]),
                        child: Icon(
                          Icons.camera_alt,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 0,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 15,
                                // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: Icon(Icons.add, color: Color(0xFFFD5C61)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "ADD MEDIA",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.8)),
              )
            ],
          ),
        ),
        Column(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, EditScreen.id),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 10,
                        blurRadius: 15,
                        // changes position of shadow
                      ),
                    ]),
                child: Icon(
                  Icons.edit,
                  size: 35,
                  color: Colors.grey.withOpacity(1),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "EDIT INFO",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.withOpacity(0.8),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget getProfileImage(AppUser user, UserProvider firebaseProvider) {
    return Stack(
      children: [
        Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePhotoPath),
            radius: 75,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kAccentColor, width: 1.0),
          ),
        ),
      ],
    );
  }
}
