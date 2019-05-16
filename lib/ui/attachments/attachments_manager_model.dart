import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halo/module/attachments.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AttachmentsModule extends ChangeNotifier {
  int indexPage = 0;
  int indexSize = 20;
  int status;
  Attachments attachments;
  List<Asset> selectImageList;

  void getAttachment(bool up, {String key, String type, String strong}) {
    if (up) {
      indexPage = 0;
    }
    Map params = HashMap<String, dynamic>();
    params["page"] = indexPage;
    params["size"] = indexSize;
//page=$page&size=$size
    ApiWithQuery<Attachments>(Api.attachments, GET, params, (data) {
      status = 200;
      if (up) {
        attachments?.content?.clear();
      }
      attachments = data;
      ++indexPage;
      notifyListeners();
    }, (code, msg) {
      status = code;
      if (up) {
        attachments?.content?.clear();
      }
      notifyListeners();
    }, () {
//       attachments.content.clear();
//      articleList.add(Content());
//      notifyListeners();
    });
  }

  void uploadFile(Asset asset) async {
    ByteData byteData = await asset.requestOriginal(quality: 50);
    List<int> imageData = byteData.buffer.asUint8List();
    FormData formData = new FormData.from({
      "file": new UploadFileInfo.fromBytes(imageData, asset.name, contentType: ContentType("", "")),
    });

    ApiWithQuery<Attachments>(Api.upload, POST, formData, (data) {
      status = 200;

      attachments = data;
      ++indexPage;
      notifyListeners();
    }, (code, msg) {
      status = code;

      notifyListeners();
    }, () {
//       attachments.content.clear();
//      articleList.add(Content());
//      notifyListeners();
    });
  }

  void loadAssets(int max) async {
    try {
      selectImageList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarTitle: "选择照片",
          allViewTitle: "选择照片",
          actionBarColor: "#0087be",
          actionBarTitleColor: "#FFFFFF",
          lightStatusBar: false,
          statusBarColor: '#006b98',
          startInAllView: true,
          selectCircleStrokeColor: "#FFFFFF",
        ),
        cupertinoOptions: CupertinoOptions(
          selectionFillColor: "#ff11ab",
          selectionTextColor: "#FFFFFF",
          selectionCharacter: "✓",
        ),
      );
    } on PlatformException catch (e) {
      ToastUtil.showToast(e.toString());
    }
    if (selectImageList != null && selectImageList.isNotEmpty) {
      //上传
      uploadFile(selectImageList[0]);
      notifyListeners();
    }
  }
}
