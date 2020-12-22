import 'package:flutter/material.dart';
import 'dart:async';
import '../utils.dart';
import 'modal.dart';
import '../../router/router.dart';

Future showModal(
    {String title = '提示',
    String content = '',
    Widget child,
    Function onConfirm,
    Function onCancel,
    String confirmText = '确定',
    String cancelText = '取消'}) async {
  createOverlayEntry(
    willPopCallback: () async {
      if (onCancel is Function) {
        await onCancel();
      }
      return true;
    },
    child: ModalWidget(
      child: child,
      confirmText: confirmText,
      cancelText: cancelText,
      onCancel: () {
        closeModal();
        if (onCancel is Function) {
          onCancel();
        }
      },
      onConfirm: () {
        closeModal();
        if (onConfirm is Function) {
          onConfirm();
        }
      },
      title: title,
      content: content,
    ),
  );
}

Future closeModal() async {
  if (OverlayStateStates.lock == true) {
    FluweRouter.navigateBack();
  }
}
