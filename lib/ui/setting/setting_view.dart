import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';

Widget getPageView(BuildContext context, List<Widget> list, Function onPressed) {
  return Scaffold(
      backgroundColor: Config.background,
      appBar: AppBar(
        title: Text("博客设置"),
        actions: <Widget>[
          IconButton(
              icon: Image.asset("assest/images/image_ok.png",
                  width: 20, height: 20, color: Colors.white),
              onPressed: onPressed)
        ],
      ),
      body: Container(
        child: getLst(list),
        color: Colors.white,
      ));
}

Widget getLst(List<Widget> list) {
  return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
      itemCount: list.length);
}

Widget buildItem(String name, TextEditingController controller,
    {TextInputType inputType, bool show = false, TextInputAction action, int minLine}) {
  return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: CustomTextField(name, controller, null,
          inputType: TextInputType.emailAddress, show: show, action: action, minLine: minLine));
}

Widget CustomTextField(
  hintText,
  controller,
  String iconPath, {
  bool show = false,
  TextInputAction action,
  TextInputType inputType,
  TextStyle labelStyle,
  String helperText,
  int minLine,
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
              minLines: minLine ?? null,
              maxLines: minLine ?? null,
              keyboardType: inputType,
              style: TextStyle(color: Config.fontColor, fontSize: 15),
              textInputAction: action,
              decoration: new InputDecoration(
                  labelText: hintText,
                  hintText: helperText ?? "",
                  labelStyle: labelStyle ?? TextStyle(fontSize: 15, color: Config.fontLightColor),
                  contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 83, 121, 148),
                          width: 1.3,
                          style: BorderStyle.solid)))))
    ],
  );
}
