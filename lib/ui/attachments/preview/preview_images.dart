import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/widget/loading_dialog.dart';

/// 预览大图

CachedNetworkImage buildCachedNetworkImage(String url, {BoxFit fit}) {
  return CachedNetworkImage(
      imageUrl: url,
      fit: fit ?? BoxFit.fill,
      placeholder: (context, url) => loading(),
      errorWidget: (context, url, error) =>
          Icon(Icons.error_outline, size: 30, color: Config.fontLightColor));
}
