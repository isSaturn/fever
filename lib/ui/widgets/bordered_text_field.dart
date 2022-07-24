import 'package:flutter/material.dart';
import 'package:fever/util/constants.dart';

class BorderedTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final TextEditingController textController;
  final FormFieldValidator<String> validator;
  final prefixIcon;
  final bool isBorder;

  BorderedTextField(
      {@required this.labelText,
      @required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.autoFocus = false,
      this.textCapitalization = TextCapitalization.none,
      this.textController,
      this.validator,
      this.prefixIcon,
      this.isBorder});

  @override
  Widget build(BuildContext context) {
    Color color = kSecondaryColor;

    return TextFormField(
      validator: validator,
      controller: textController,
      onChanged: onChanged,
      obscureText: obscureText,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: TextStyle(color: kSecondaryColor.withOpacity(0.5)),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: isBorder ? color : Colors.transparent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }
}
