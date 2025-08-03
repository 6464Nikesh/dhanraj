import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitTradeDialogs extends StatefulWidget {
  final Function() onTap;

  const ExitTradeDialogs({
    super.key,
    required this.onTap,
  });

  @override
  State<ExitTradeDialogs> createState() => _ExitTradeDialogsState();
}

class _ExitTradeDialogsState extends State<ExitTradeDialogs> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        AppStrings.exitTrade,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      content: Text(
        AppStrings.areYouSureYouWantToExit,
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
          onPressed: widget.onTap,
          child: Text(
            AppStrings.exit,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
