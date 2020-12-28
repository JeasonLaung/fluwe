import 'preview_image.dart';
import 'dart:async';
import '../utils.dart';
import '../../router/router.dart';
import '../../helpers/helpers.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

// import 'package:dio/dio.dart';
// import 'dart:io';

class _PreviewImageParam {
  static int index = 0;
}

Future previewImage(
    {List<String> urls, String current, Function(int) onPageChanged}) async {
  int index = urls.indexOf(current);
  createOverlayEntry(
      child: PreviewImageWidget(
    defaultIndex: index,
    indicators: true,
    onPageChanged: (int _index) {
      index = _index;
    },
    onLongPress: (ind) {
      showActionSheet(
          itemList: ['保存图片'],
          success: (val) async {
            if (val == '保存图片') {
              // 不能同时下载不然闪退，所以要等一等
              showLoading(canBack: false);
              GallerySaver.saveImage(urls[ind]).then((isSuccess) {
                closeLoading();
                if (isSuccess) {
                  showToast("图片已保存至相册");
                } else {
                  showToast("图片保存失败");
                }
              });

              // String ext = urls[index].split('.').last;
              /// 获取图片后缀
              // Directory dir = await getApplicationDocumentsDirectory();
              // String path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$ext';
              // showLoading();
              // await Dio().download(urls[index], path);
              // showToast("图片已保存至$path");
              // closeLoading();
            }
          });
    },
    maskClick: () {
      FluweRouter.navigateBack();
    },
    images: urls,
  ));
}
