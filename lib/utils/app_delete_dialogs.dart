import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDeleteDialogs extends StatefulWidget {
  const AppDeleteDialogs({
    super.key,
  });

  @override
  State<AppDeleteDialogs> createState() => _AppDeleteDialogsState();
}

class _AppDeleteDialogsState extends State<AppDeleteDialogs> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        AppStrings.delete,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      content: Text(
        AppStrings.areYouSureYouWantToDelete,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context,true);
          },
          child: Text(
            AppStrings.delete,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
