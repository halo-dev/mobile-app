import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/ui/category/dropdownmenu_item.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/login_text_field.dart';

class CreateCategoryPage extends StatelessWidget {
  Category item;
  bool modify;

  CreateCategoryPage(this.item, this.modify);

  CreateCategoryPage.create() {
    modify = false;
  }

  final TextEditingController _nameCtl = new TextEditingController();
  final TextEditingController _desCtl = new TextEditingController();
  final TextEditingController _singeCtl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
            (modify && item != null) ? "修改分类" : (!modify && item != null) ? item.name : "创建分类"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                _update(context);
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 2),
        child: _buildCreate(context),
      ),
    );
  }

  _buildCreate(BuildContext context) {
    //修改
    if (modify && item != null) {
      _nameCtl.text = item.name;
      _desCtl.text = item.description;
      _singeCtl.text = item.slugName;
      Provide.value<CategoryListModule>(context).currentCategory(item);
    } else
      Provide.value<CategoryListModule>(context)
          .currentChange(Provide.value<CategoryListModule>(context).top);
    //创建

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "父级分类(可选)",
            style: TextStyle(fontSize: 13, color: Config.fontLightColor),
          ),
          _buildDropMenu(),
          loginTextField("* 分类名称", _nameCtl, null,
              labelStyle: TextStyle(fontSize: 15, color: Colors.pink)),
          loginTextField("分类描述", _desCtl, null),
          loginTextField("slug", _singeCtl, null, inputType: TextInputType.url),
        ],
      ),
    );
  }

  Widget _buildDropMenu() {
    return Provide<CategoryListModule>(builder: (context, child, mode) {
      if (mode.cateList == null) {
        return buildTop(context);
      } else if (mode.cateList != null && mode.cateList.list.isNotEmpty) {
        //创建和更新

        List<DropdownMenuItem<Category>> items = new List<DropdownMenuItem<Category>>();
        for (var value1 in mode.cateList.list) {
//          if (item != null && value1.id == item.id) continue;
          items.addAll(createDropdownMenuItem(value1, item == null ? 0 : item.id, context));
        }

        items.insert(
            0,
            DropdownMenuItem(
              value: mode.top,
              child: Text(
                mode.top.name,
                style: TextStyle(fontSize: 15, color: Config.fontColor),
              ),
            ));
        return DropdownButton(
          items: items,
          hint: Text(mode.current.name),
          onChanged: (value) {
            mode.currentChange(value);
          },
        );
      } else {
        return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "顶级",
              style: TextStyle(fontSize: 15, color: Config.fontColor),
            ));
      }
    });
  }

  Widget buildTop(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "分类信息获取失败",
                style: TextStyle(fontSize: 15, color: Config.fontColor),
              )),
        ),
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provide.value<CategoryListModule>(context).updateList();
            })
      ],
    );
  }

  void _update(BuildContext context) {
    var mode = Provide.value<CategoryListModule>(context);
    if (item != null && item.id == mode.current.id) {
      ToastUtil.showToast("父级分类不能是自己");
      return;
    }

    Category category = Category.fromParams(
        id: item != null ? item.id : 0,
        parentId: mode.current.id,
        description: _desCtl.text,
        name: _nameCtl.text,
        slugName: _singeCtl.text);

    if (item != null && modify) {
      //更新
      Provide.value<CategoryListModule>(context).update(category, context);
    } else {
      //创建
      Provide.value<CategoryListModule>(context).create(category, context);
    }
  }
}
