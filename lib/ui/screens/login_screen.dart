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
    if (_formKey.currentState.validate()) {
      setState(
        () {
          _isLoading = true;
        },
      );
      await _userProvider
          .loginUser(_inputEmail, _inputPassword, _scaffoldKey)
          .then(
        (response) {
          if (response is Success<UserCredential>) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                TopNavigationScreen.id, (route) => false);
          }
        },
      );
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Login'),
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
                          return ("Please Enter Your Email");
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                    ),
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
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                      },
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
