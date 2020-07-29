import "package:flutter/material.dart";

class Button extends StatelessWidget {
  final String title;
  final Function onPress;
  final BorderRadius borderRadius;
  final Color textColor;
  final Color buttonColor;
  final double width;
  final double height;
  final TextStyle textStyle;
  final bool enabled;
  final Border border;

  Button({
    @required this.title,
    this.onPress,
    BorderRadius borderRadius,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 60,
    this.buttonColor,
    this.textStyle = const TextStyle(),
    this.enabled = true,
    Border border,
  })  : this.borderRadius = borderRadius ?? BorderRadius.circular(30),
        this.border = border ?? Border.all(color: Colors.lightBlue, width: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
      ),
      child: RaisedButton(
        textColor: textColor,
        disabledTextColor: textColor,
        color: buttonColor ?? Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        onPressed: enabled ? onPress : null,
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}
