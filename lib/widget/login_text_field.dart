import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';

Widget loginTextField(
  hintText,
  controller,
  String iconPath, {
  bool show = false,
  TextInputAction action,
  TextInputType inputType,
  TextStyle labelStyle,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      iconPath != null
          ? Image.asset(
              iconPath,
              width: 23,
              height: 23,
              color: Color.fromARGB(255, 168, 190, 206),
            )
          : SizedBox(
              width: 0,
            ),
      SizedBox(
        width: iconPath != null ? 15 : 0,
      ),
      Expanded(
          child: TextField(
              controller: controller,
              autofocus: true,
              obscureText: show,
              focusNode: null,
              keyboardType: inputType,
              textInputAction: action,
              decoration: new InputDecoration(
                  labelText: hintText,
                  labelStyle: labelStyle == null
                      ? TextStyle(fontSize: 15, color: Config.fontLightColor)
                      : labelStyle,
                  contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 83, 121, 148),
                          width: 1.0,
                          style: BorderStyle.solid)))))
    ],
  );
}