import 'package:flutter/material.dart';
import 'package:fever/ui/widgets/bordered_text_field.dart';

import '../../../data/model/user_registration.dart';

enum BestTutorSite { male, female, other }

BestTutorSite _site = BestTutorSite.male;

class NameScreen extends StatelessWidget {
  final Function(String) onChanged;
  final Function(bool) onChangedMale;
  final Function(bool) onChangedFemale;

  final UserRegistration _userRegistration = UserRegistration();

  NameScreen(
      {@required this.onChanged,
      @required this.onChangedMale,
      this.onChangedFemale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'My first',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'name is',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Expanded(
          child: BorderedTextField(
            labelText: 'Name',
            onChanged: onChanged,
            textCapitalization: TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
