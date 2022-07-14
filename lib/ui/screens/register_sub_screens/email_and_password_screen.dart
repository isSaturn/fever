import 'package:flutter/material.dart';
import 'package:fever/ui/widgets/bordered_text_field.dart';
import 'package:fever/util/constants.dart';

class EmailAndPasswordScreen extends StatelessWidget {
  final Function(String) emailOnChanged;
  final Function(String) passwordOnChanged;

  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> passwordValidator;

  EmailAndPasswordScreen(
      {@required this.emailOnChanged,
      @required this.passwordOnChanged,
      @required this.emailValidator,
      @required this.passwordValidator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign Up',
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: kAccentColor,
                )),
        SizedBox(
          child: Image.asset('images/signup.png'),
          width: 200.0,
          height: 200.0,
        ),
        SizedBox(height: 25),
        BorderedTextField(
          labelText: 'Email',
          onChanged: emailOnChanged,
          keyboardType: TextInputType.emailAddress,
          validator: emailValidator,
        ),
        SizedBox(height: 5),
        BorderedTextField(
          labelText: 'Password',
          onChanged: passwordOnChanged,
          obscureText: true,
          validator: passwordValidator,
        ),
      ],
    );
  }
}
