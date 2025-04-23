import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';

class HttpErrorDialog extends StatefulWidget {
  final String? msg;
  final Future<dynamic>? Function() onTap;

  HttpErrorDialog({super.key, required this.msg, required this.onTap});

  @override
  State<HttpErrorDialog> createState() => _HttpErrorDialogState();
}

class _HttpErrorDialogState extends State<HttpErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                widget.msg ?? "",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: AppButton.button(
                  text: AppStrings.close,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
