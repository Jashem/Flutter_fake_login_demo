import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    Key key,
    @required this.label,
    this.icon,
    this.validator,
    this.onSaved,
    this.secureText = false,
    this.maxLine = 1,
    this.onChanged,
    this.suffix,
    this.keyboardType,
    this.color,
    this.initalValue,
    this.readOnly = false,
    this.onTap,
    this.inputFormaters,
    this.textEditingController,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final bool secureText;
  final int maxLine;
  final Color color;
  final Widget suffix;
  final String initalValue;
  final bool readOnly;
  final Function onTap;
  final TextInputType keyboardType;
  final List<WhitelistingTextInputFormatter> inputFormaters;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormaters,
      controller: textEditingController,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initalValue,
      onChanged: onChanged,
      maxLines: maxLine,
      cursorColor: (color != null) ? color : Theme.of(context).accentColor,
      autocorrect: false,
      obscureText: secureText,
      style: TextStyle(
        color: (color != null) ? color : Theme.of(context).accentColor,
        fontSize: deviceSize.height * 0.02,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: (color != null) ? color : Theme.of(context).accentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: (color != null) ? color : Theme.of(context).accentColor,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
            color: (color != null) ? color : Theme.of(context).accentColor),
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: (color != null) ? color : Theme.of(context).accentColor,
              ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: (color != null) ? color : Theme.of(context).accentColor,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
