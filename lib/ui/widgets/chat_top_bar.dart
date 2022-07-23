import 'package:flutter/material.dart';
import 'package:fever/data/db/entity/app_user.dart';
import 'package:fever/util/constants.dart';
import 'package:fever/data/db/entity/match.dart';
import '../../data/db/remote/firebase_database_source.dart';
import '../screens/top_navigation_screen.dart';

class ChatTopBar extends StatelessWidget {
  final AppUser user;

  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();

  ChatTopBar({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kAccentColor, width: 1.0),
              ),
              child: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(user.profilePhotoPath)),
            )
          ],
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: kAccentColor),
            ),
          ],
        ),
      ],
    );
  }
}
