import 'preview_image.dart';
import 'dart:async';
import '../utils.dart';

import '../../helpers/helpers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';

Future previewImage({List<String> urls, String current, Function(int) onPageChanged}) async{
  int index = urls.indexOf(current);
  createOverlayEntry(
    child: PreviewImageWidget(
      defaultIndex: index,
      indicators: true,
      onPageChanged: (_index) {
        index = _index;
      },
      onLongPress: () {
        showActionSheet(
          itemList: ['保存图片'],
          onChange: (val) async{
            if (val == '保存图片') {
              /// 获取图片后缀
              String ext = urls[index].split('.').last;
              Directory dir = await getApplicationDocumentsDirectory();
              String path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$ext';
              showLoading();
              await Dio().download(urls[index], path);
              showToast("图片已保存至$path");
              closeLoading();
            }
          }
        );
      },
      maskClick: () {
        Router.navigateBack();
      },
      images: urls,
    )
  );
}
