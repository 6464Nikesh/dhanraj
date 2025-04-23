import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String? subtitle;
 final String? title;
 final Future<dynamic>? Function() onTap;

  const ConfirmationDialog({super.key, required this.subtitle, required this.title, required this.onTap});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title ?? ""),
      content: Text(widget.subtitle ?? ""),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        TextButton(
          onPressed: widget.onTap,
          child: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}
