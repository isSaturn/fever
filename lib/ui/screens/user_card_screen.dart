import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/data/db/entity/chat.dart';
import 'package:fever/data/db/entity/match.dart';
import 'package:fever/data/db/entity/swipe.dart';
import 'package:fever/data/db/remote/firebase_database_source.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/matched_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/ui/widgets/rounded_icon_button.dart';
import 'package:fever/ui/widgets/swipe_card.dart';
import 'package:fever/ui/widgets/user_card_form.dart';
import 'package:fever/util/constants.dart';
import 'package:fever/util/utils.dart';

class UserCard extends StatefulWidget {
  static const String id = 'user_card_screen';

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _ignoreSwipeIds;
  String preference;
  String gender;

  Future<AppUser> loadPerson(String myUserId) async {
    print("Ignore swipe ids: ");
    _ignoreSwipeIds = <String>[];
    if (_ignoreSwipeIds.isEmpty) {
      print("Made it!");
      preference = await _databaseSource.getPreference(myUserId);
      gender = await _databaseSource.getGender(myUserId);
      var swipes = await _databaseSource.getSwipes(myUserId);
      for (var i = 0; i < swipes.size; i++) {
        Swipe swipe = Swipe.fromSnapshot(swipes.docs[i]);
        _ignoreSwipeIds.add(swipe.id);
      }
      _ignoreSwipeIds.add(myUserId);
    }
    var res = await _databaseSource.getPersonsToMatchWith(
        _ignoreSwipeIds, gender, preference);
    print(res.toString());
    if (res.docs.length > 0) {
      var userToMatchWith = AppUser.fromSnapshot(res.docs.first);

      return userToMatchWith;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                  inAsyncCall:
                      userProvider.user == null || userProvider.isLoading,
                  child: (userSnapshot.hasData)
                      ? FutureBuilder<AppUser>(
                          future: loadPerson(userSnapshot.data.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasData) {
                              return Center(
                                child: Container(
                                    child: Text('No users',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4)),
                              );
                            }
                            if (!snapshot.hasData) {
                              return CustomModalProgressHUD(
                                inAsyncCall: true,
                                child: Container(),
                              );
                            }
                            return UserCardForm(person: snapshot.data);
                          })
                      : Container(),
                );
              },
            );
          },
        )));
  }
}
