import 'package:flutter/cupertino.dart';
import '../../router/router.dart';
import '../action_sheet/action_sheet.dart';
import '../../overlay/utils.dart';

showActionSheet(
    {@required List itemList, Function onCancel, Function(dynamic) onChange}) {
  createOverlayEntry(
      willPopCallback: () async {
        if (onCancel is Function) {
          await onCancel();
        }
        return true;
      },
      child: ActionSheetWidget(
        cancelButton: '取消',
        onChange: (int index) {
          FluweRouter.navigateBack();
          if (onChange is Function) {
            return onChange(
              itemList[index] is Map
                  ? itemList[index]['value']
                  : itemList[index],
            );
          }
        },
        close: () async {
          FluweRouter.navigateBack();
          if (onCancel is Function) {
            await onCancel();
          }
        },
        childer: List.generate(itemList.length, (index) {
          if (itemList[index] is Map) {
            return ActionsheetItem(
                label:
                    toTextWidget(itemList[index]['title'], 'action_sheet_item'),
                value: index.toString());
          } else {
            return ActionsheetItem(
                label: toTextWidget(itemList[index], 'action_sheet_item'),
                value: index.toString());
          }
        }).toList(),
      ));
}
