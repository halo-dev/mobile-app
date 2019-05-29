import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/options.dart';
import 'package:halo/ui/setting/setting_module.dart';

abstract class SettingPageBase extends BaseState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.background,
        appBar: AppBar(
          elevation: 0,
          title: Text(getTitle()),
          actions: <Widget>[
            IconButton(
                icon: Image.asset("assest/images/image_ok.png",
                    width: 20, height: 20, color: Colors.white),
                onPressed: onSaved)
          ],
        ),
        body: Container(
          child: Provide<SettingModule>(builder: (context, child, mode) {
            return getLst(buildWidgetList(mode.options));
          }),
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

  @override
  void onFirstInit() {}

  Widget buildItem(String name, TextEditingController controller,
      {TextInputType inputType, bool show = false, TextInputAction action, int minLine}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
        child: CustomTextField(name, controller,
            inputType: TextInputType.emailAddress, show: show, action: action, minLine: minLine));
  }

  Widget CustomTextField(
    hintText,
    controller, {
    bool show = false,
    TextInputAction action,
    TextInputType inputType,
    TextStyle labelStyle,
    String helperText,
    int minLine,
  }) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(hintText, style: TextStyle(fontSize: 12, color: Config.fontLightColor)),
          SizedBox(height: 4),
          TextField(
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
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 83, 121, 148),
                          width: 1.3,
                          style: BorderStyle.solid))))
        ]);
  }

  List<Widget> buildWidgetList(Options options);

  void onSaved();

  saveData() {
    Provide.value<SettingModule>(context).saveSetting();
  }

  String getTitle();
}
