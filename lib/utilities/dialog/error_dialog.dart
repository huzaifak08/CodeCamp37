import 'package:codecamp37/utilities/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(
    context: context,
    title: 'An Error Occoured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
