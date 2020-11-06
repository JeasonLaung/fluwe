import 'package:flutter/material.dart';
import 'dart:async';
import '../utils.dart';
import 'modal.dart';

Future showModal({String title,String content,Widget child,Function onConfirm, Function onCancel}) async{
  createOverlayEntry(
    willPopCallback: () async{
      if (onCancel is Function) {
        await onCancel();
      }
      return true;
    },
    child: ModalWidget(
      child: child,
      onCancel: () async{
        closeModal();
        if (onCancel is Function) {
          await onCancel();
        }
      },
      onConfirm: () async{
        closeModal();
        if (onCancel is Function) {
          await onConfirm();
        }
      },
      title: title,
      content: content,
    ),
  );
}

Future closeModal() async{
  if (OverlayStateStates.lock == false) {
    OverlayStateStates.lock = true;
    Router.navigateBack();
  }
}
