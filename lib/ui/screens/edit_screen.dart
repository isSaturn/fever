import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/start_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/ui/widgets/input_dialog.dart';
import 'package:fever/ui/widgets/rounded_button.dart';
import 'package:fever/ui/widgets/rounded_icon_button.dart';
import 'package:fever/util/constants.dart';

class EditScreen extends StatefulWidget {
  static const String id = 'edit_screen';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 42.0,
          horizontal: 18.0,
        ),
        margin: EdgeInsets.only(bottom: 40),
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                    inAsyncCall:
                        userProvider.user == null || userProvider.isLoading,
                    child: userSnapshot.hasData
                        ? Column(children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${userSnapshot.data.name}, ${userSnapshot.data.age}',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                RoundedIconButton(
                                  onPressed: () {
                                    buttonChangeNameAndAge(
                                        userSnapshot.data, userProvider);
                                  },
                                  iconData: Icons.edit,
                                  iconSize: 18,
                                  paddingReduce: 4,
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            getBio(userSnapshot.data, userProvider),
                            getMajors(userSnapshot.data, userProvider),
                            Expanded(child: Container()),
                          ])
                        : Container());
              });
        }),
      ),
    );
  }

  Widget getMajors(AppUser user, UserProvider userProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Majors', style: Theme.of(context).textTheme.headline4),
            RoundedIconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => InputDialog(
                    onSavePressed: (value) =>
                        userProvider.updateUserMajors(value),
                    labelText: 'Majors',
                    startInputText: user.majors,
                  ),
                );
              },
              iconData: Icons.edit,
              iconSize: 18,
              paddingReduce: 4,
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user.majors.length > 0 ? user.majors : "No majors.",
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
            Text('Bio', style: Theme.of(context).textTheme.headline4),
            RoundedIconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => InputDialog(
                    onSavePressed: (value) => userProvider.updateUserBio(value),
                    labelText: 'Bio',
                    startInputText: user.bio,
                  ),
                );
              },
              iconData: Icons.edit,
              iconSize: 18,
              paddingReduce: 4,
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user.bio.length > 0 ? user.bio : "No bio.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  void buttonChangeNameAndAge(AppUser user, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (_) => InputDialog(
        onSavePressed: (value) => userProvider.updateUserName(value),
        labelText: 'Name',
        startInputText: user.name,
      ),
    );
  }
}
