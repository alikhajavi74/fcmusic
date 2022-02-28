/*
// PubDev main package: https://pub.dev/packages/image_picker
// PubDev main package: https://pub.dev/packages/image_cropper

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// --------------------------------------------------------------------------------------------------------------------

// My image picker dialog:

Future<File?> mShowPickImageDialog(BuildContext context) async {
  AlertDialog alertDialog = AlertDialog(
    alignment: Alignment.center,
    title: const Text("انتخاب تصویر", textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w600)),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
    actions: [
      IconButton(
        icon: const Icon(Icons.camera_alt, size: 50, color: Colors.blueGrey),
        padding: const EdgeInsets.all(0.0),
        onPressed: () async {
          File? file = await mImagePickerAndCropper(ImageSource.camera);
          Navigator.of(context).pop(file);
        },
      ),
      const SizedBox(width: 25),
      IconButton(
        icon: const Icon(Icons.image_rounded, size: 50, color: Colors.blueGrey),
        padding: const EdgeInsets.all(0.0),
        onPressed: () async {
          File? file = await mImagePickerAndCropper(ImageSource.gallery);
          Navigator.of(context).pop(file);
        },
      ),
    ],
  );

  File? finalFile = await showDialog<File?>(
    context: context,
    barrierDismissible: true,
    builder: (context) => alertDialog,
  );

  return finalFile;
}

// --------------------------------------------------------------------------------------------------------------------

// My image picker function:

Future<File?> mImagePickerAndCropper(ImageSource imageSource, {double maxWidth = 480, double maxHeight = 480, int imageQuality = 100}) async {
  XFile? xFile = await ImagePicker().pickImage(
    source: imageSource,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
  );

  if (xFile != null) {
    return await ImageCropper().cropImage(
      sourcePath: xFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.original],
      androidUiSettings: const AndroidUiSettings(toolbarTitle: 'ویرایش تصویر', toolbarColor: Colors.black, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.square, lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0),
    );
  }
  return null;
}

// --------------------------------------------------------------------------------------------------------------------
*/
