import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/start_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/ui/widgets/rounded_button.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                            Expanded(child: Container()),
                            RoundedButton(
                              text: 'LOGOUT',
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userProvider.currentUserId)
                                    .update({'isOnline': false});
                                logoutPressed(userProvider, context);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RoundedButton(
                              text: 'DELETE',
                              onPressed: () {},
                            )
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
}
