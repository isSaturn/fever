import 'package:flutter/material.dart';

import '../../util/constants.dart';

class Preference extends StatefulWidget {
  final Function(String) onChanged;

  Preference({@required this.onChanged});

  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  String gender;
  bool clicked1 = false;
  bool clicked2 = false;
  bool clicked3 = false;

  setGender() {
    widget.onChanged(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Preference',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
                color: clicked1 ? kAccentColor : Colors.grey.shade800,
                padding: EdgeInsets.symmetric(vertical: 14),
                highlightElevation: 0,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Nam', style: Theme.of(context).textTheme.button),
                onPressed: () {
                  setState(() {
                    gender = "male";
                    clicked1 = true;
                    clicked2 = false;
                    clicked3 = false;
                  });
                  setGender();
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
                color: clicked2 ? kAccentColor : Colors.grey.shade800,
                padding: EdgeInsets.symmetric(vertical: 14),
                highlightElevation: 0,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Nữ', style: Theme.of(context).textTheme.button),
                onPressed: () {
                  setState(() {
                    gender = "female";
                    clicked1 = false;
                    clicked2 = true;
                    clicked3 = false;
                  });
                  setGender();
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
                color: clicked3 ? kAccentColor : Colors.grey.shade800,
                padding: EdgeInsets.symmetric(vertical: 14),
                highlightElevation: 0,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Khác', style: Theme.of(context).textTheme.button),
                onPressed: () {
                  setState(() {
                    gender = "other";
                    clicked1 = false;
                    clicked2 = false;
                    clicked3 = true;
                  });
                  setGender();
                }),
          ),
        ],
      ),
    );
  }
}