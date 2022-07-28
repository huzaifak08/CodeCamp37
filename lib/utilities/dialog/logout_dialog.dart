import 'package:codecamp37/utilities/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Log Out',
    content: 'Are You sure you want to Log Out',
    optionBuilder: () => {
      'cancel': false,
      'Log out': true,
    },
  ).then((value) => value ?? false);
}
