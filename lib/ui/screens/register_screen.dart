import 'package:fever/ui/screens/gender_screen.dart';
import 'package:fever/ui/screens/interests_screen.dart';
import 'package:fever/ui/screens/location_screen.dart';
import 'package:fever/ui/screens/preference_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/remote/response.dart';
import 'package:fever/data/model/user_registration.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/register_sub_screens/add_photo_screen.dart';
import 'package:fever/ui/screens/register_sub_screens/age_screen.dart';
import 'package:fever/ui/screens/register_sub_screens/email_and_password_screen.dart';
import 'package:fever/ui/screens/register_sub_screens/name_screen.dart';
import 'package:fever/ui/screens/top_navigation_screen.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/ui/widgets/rounded_button.dart';
import 'package:fever/util/constants.dart';
import 'package:fever/util/utils.dart';
import 'package:fever/ui/screens/start_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserRegistration _userRegistration = UserRegistration();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _endScreenIndex = 7;
  int _currentScreenIndex = 0;
  bool _isLoading = false;
  UserProvider _userProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  void registerUser() async {
    setState(() {
      _isLoading = true;
    });

    await _userProvider
        .registerUser(_userRegistration, _scaffoldKey)
        .then((response) {
      if (response is Success) {
        Navigator.pop(context);
        Navigator.pushNamed(context, TopNavigationScreen.id);
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  void goBackPressed() {
    if (_currentScreenIndex == 0) {
      Navigator.pop(context);
      Navigator.pushNamed(context, StartScreen.id);
    } else {
      setState(() {
        _currentScreenIndex--;
      });
    }
  }

  Widget getSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return NameScreen(
            onChanged: (value) => {_userRegistration.name = value});
      case 1:
        return AgeScreen(onChanged: (value) => {_userRegistration.age = value});

      case 2:
        return AddPhotoScreen(
            onPhotoChanged: (value) =>
                {_userRegistration.localProfilePhotoPath = value});
      case 3:
        return Gender(onChanged: (value) => {_userRegistration.gender = value});
      case 4:
        return Preference(
            onChanged: (value) => {_userRegistration.preference = value});
      case 5:
        print("get subscreen case 3");
        return InterestsScreen(onInterestsChanged: (value) {
          print("list : ${value.toString()}");
          _userRegistration.interests = value;
        });

      case 6:
        return Location(onChanged: (value) {
          _userRegistration.city = value['city'];
          _userRegistration.state = value['state'];
          _userRegistration.country = value['country'];
        });
      case 7:
        return Form(
          key: _formKey,
          child: EmailAndPasswordScreen(
              emailValidator: (value) {
                if (value.isEmpty) {
                  return ("Vui lòng điền Email");
                }
                // reg expression for email validation
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("Vui lòng nhập đúng Email");
                }
                if (!RegExp("@vanlanguni.vn").hasMatch(value)) {
                  return ("Please use domain name @vanlanguni.vn");
                }
                return null;
              },
              emailOnChanged: (value) => {_userRegistration.email = value},
              // ignore: missing_return
              passwordValidator: (value) {
                RegExp regex = new RegExp(r'^.{6,}$');
                if (value.isEmpty) {
                  return ("Vui lòng điền mật khẩu");
                }
                if (!regex.hasMatch(value)) {
                  return ("Mật khẩu không hơp lệ (Ít nhất 6 ký tự)");
                }
              },
              passwordOnChanged: (value) =>
                  {_userRegistration.password = value}),
        );
      default:
        return Container();
    }
  }

  bool canContinueToNextSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return (_userRegistration.name.length >= 2);
      case 1:
        return (_userRegistration.age >= 18 && _userRegistration.age <= 120);
      case 2:
        return _userRegistration.localProfilePhotoPath.isNotEmpty;
      case 3:
        return (_userRegistration.gender.length > 1);
      case 4:
        return (_userRegistration.preference.length > 1);
      case 5:
        return (_userRegistration.interests.isNotEmpty);
      case 6:
        return (_userRegistration.city.isNotEmpty);
      default:
        return false;
    }
  }

  String getInvalidRegistrationMessage() {
    switch (_currentScreenIndex) {
      case 0:
        return "Tên quá ngắn";
      case 1:
        return "Bạn chưa đủ tuổi";
      case 2:
        return "Vui lòng chọn ảnh";
      case 3:
        return "Vui lòng chọn giới tính";
      case 4:
        return 'Vui lòng chọn đối tượng tìm kiếm';
      case 5:
        return "Vui lòng chọn sở thích";
      case 6:
        return 'Vui lòng chọn vị trí';
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Đăng ký')),
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Container(
                  child: LinearPercentIndicator(
                      lineHeight: 5,
                      percent: (_currentScreenIndex / _endScreenIndex),
                      progressColor: kAccentColor,
                      padding: EdgeInsets.zero),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: kDefaultPadding.copyWith(
                          left: kDefaultPadding.left / 2.0,
                          right: 0.0,
                          bottom: 4.0,
                          top: 4.0),
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          _currentScreenIndex == 0
                              ? Icons.clear
                              : Icons.arrow_back,
                          color: kAccentColor,
                          size: 42.0,
                        ),
                        onPressed: () {
                          goBackPressed();
                        },
                      )),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      child: getSubScreen(),
                      padding: kDefaultPadding.copyWith(top: 0, bottom: 0)),
                ),
                Container(
                  padding: kDefaultPadding,
                  child: _currentScreenIndex == (_endScreenIndex)
                      ? RoundedButton(
                          text: 'GÉT GÔ!',
                          onPressed: _isLoading == false
                              ? () => {
                                    if (_formKey.currentState.validate())
                                      {registerUser()}
                                  }
                              : null)
                      : RoundedButton(
                          text: 'TIẾP THEO',
                          onPressed: () => {
                            if (canContinueToNextSubScreen())
                              setState(() {
                                _currentScreenIndex++;
                              })
                            else
                              showSnackBar(
                                  _scaffoldKey, getInvalidRegistrationMessage())
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
