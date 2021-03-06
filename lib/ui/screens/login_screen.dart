import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever/data/db/remote/response.dart';
import 'package:fever/data/provider/user_provider.dart';
import 'package:fever/ui/screens/top_navigation_screen.dart';
import 'package:fever/ui/widgets/bordered_text_field.dart';
import 'package:fever/ui/widgets/custom_modal_progress_hud.dart';
import 'package:fever/ui/widgets/rounded_button.dart';
import 'package:fever/util/constants.dart';

import '../widgets/input_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of(context, listen: false);
  }

  void loginPressed() async {
    setState(() {
      _isLoading = true;
    });
    await _userProvider
        .loginUser(_inputEmail, _inputPassword, _scaffoldKey)
        .then((response) {
      if (response is Success<UserCredential>) {
        Provider.of<UserProvider>(context, listen: false).currentUserId =
            response.value.user.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(response.value.user.uid)
            .update({'isOnline': true});
        Navigator.of(context)
            .pushNamedAndRemoveUntil(TopNavigationScreen.id, (route) => false);
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  void resetPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("link has been sent to your email for password reset")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('????ng nh???p'),
        ),
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Padding(
            padding: kDefaultPadding,
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: Image(
                            image: AssetImage('images/login.png'),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 40),
                    BorderedTextField(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _inputEmail = value,
                        textController: emailEditingController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Vui l??ng nh???p ????ng Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Vui l??ng nh???p ????ng Email");
                          }
                          return null;
                        },
                        isBorder: true),
                    SizedBox(height: 5),
                    BorderedTextField(
                        labelText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => _inputPassword = value,
                        textController: passwordEditingController,
                        // ignore: missing_return
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value.isEmpty) {
                            return ("Vui l??ng ??i???n m???t kh???u");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("M???t kh???u kh??ng h??p l??? (??t nh???t 6 k?? t???)");
                          }
                        },
                        isBorder: true),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => InputDialog(
                            onSavePressed: (value) =>
                                resetPassword(value.trim()),
                            labelText: 'Nh???p ?????a ch??? email ????? ?????t l???i m???t kh???u',
                          ),
                        );
                      },
                      child: Text("Forgot password?"),
                    ),
                    Expanded(child: Container()),
                    RoundedButton(
                        text: 'LOGIN', onPressed: () => loginPressed())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
