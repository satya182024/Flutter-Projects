import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todolist/main.dart';
import 'package:todolist/utils/app_str.dart';

String lottieURL = 'assets/lottie/1.json';
//Empty title or subtitle
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You must fill all the fields',
      corner: 20.0,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

//Nothing entered
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You must edit the task then try to update it',
      corner: 20.0,
      duration: 5000,
      padding: const EdgeInsets.all(20));
}

dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppStr.oopsMsg,
      message: "There is no Task to delete\n Try adding some tasks",
      buttonText: "Okay", onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      message:
          "Do you really want to delete all tasks> You will not be able to undo this action!",
      confirmButtonText: 'Yes',
      cancelButtonText: 'No', onTapConfirm: () {
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error, barrierDismissible: false);
}
