import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_colors.dart';
import 'app_strings.dart';

class ChooseImageProvider extends ChangeNotifier {
  File? file;

  Future<File?> showBottomSheetChooseFile({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.browse,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _takePhoto(context: context).then(
                          (value) {
                            if (value != null) {
                              file = value;
                              notifyListeners();
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera,
                            size: 30,
                            color: AppColors.darkBlue,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Camara",
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _choosePhoto(context: context).then(
                          (value) {
                            if (value != null) {
                              file = value;
                              notifyListeners();
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo,
                            size: 30,
                            color: AppColors.darkBlue,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Photos",
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    ).then(
      (value) {
        return file;
      },
    );
    return file;
  }

  Future<File?> _takePhoto({required BuildContext context}) async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      // Attempt to pick an image from the camera
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        // If an image is picked, save it to the file and update file name
        return File(pickedFile.path);
      } else {
        // If no file is picked, prompt to enable settings
        //_showPermissionDialog(context);
      }
    } catch (e) {
      if (e is PlatformException && e.code == 'camera_access_denied') {
        print(e.code);
        _showPermissionDeniedForCamaraDialog(context);
      } else {
        print("An unknown error occurred: $e");
      }
    }
    return null;
  }

  String? convertToBase64(File? file) {
    List<int>? imageBytes = file?.readAsBytesSync() ?? [];
    if (imageBytes.isNotEmpty) {
      return const Base64Encoder().convert(imageBytes);
    } else {
      return null;
    }
  }

  Future<File?> _choosePhoto({required BuildContext context}) async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      // Attempt to pick an image from the camera
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      if (e is PlatformException && e.code == 'photo_access_denied') {
        print(e.code);
        _showPermissionDeniedForCamaraDialog(context);
        return null;
      } else {
        print("An unknown error occurred: $e");
        return null;
      }
    }
    return null;
  }

  removeImage() {
    file = null;
    notifyListeners();
  }

  void _showPermissionDeniedForCamaraDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(AppStrings.camaraPermissionDenied),
          content: const Text(AppStrings.thisAppNeedsCamaraPermissionToAccessYourCurrentLocationPleaseEnableItInYourSettings),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppStrings.settings,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                openAppSettings();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                AppStrings.cancel,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
