import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';

class notif {
  void eroroAlertIsEmpty(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SmartAlertDialog(
          isDismissible: true,
          title: 'Message Login',
          text: AlertDialogText(),
          message: '${context}'),
    );
  }

  void erorsnackbar(eror) {
    AnimatedSnackBar.material(
      '$eror',
      type: AnimatedSnackBarType.info,
    ).show(eror);
  }

  void snackbarSucses(BuildContext context, title, deskripsi) {
    AnimatedSnackBar.rectangle(
      '${title}',
      '${deskripsi}',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(context
        );
  }
}
