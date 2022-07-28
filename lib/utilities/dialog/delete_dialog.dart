import 'package:codecamp37/utilities/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are You sure you want to Delete this Item?',
    optionBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}
