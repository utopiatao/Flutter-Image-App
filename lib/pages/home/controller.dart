import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AlbumController extends GetxController {
  List<Photo> list = [];

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    final dir = await getApplicationSupportDirectory();

    for (var entity in dir.listSync()) {
      final file = File(entity.path);
      final bytes = file.readAsBytesSync();
      final image = await decodeImageFromList(bytes);
      list.add(
        Photo(
          path: file.path,
          name: file.path.split('/').last,
          width: image.width,
          height: image.height,
          bytes: bytes,
        ),
      );
    }
    update();
  }

  Future<void> add({required bool isCamera}) async {
    await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery).then((picker) async {
      if (null != picker) {

        final dir = await getApplicationSupportDirectory();

        final ext = picker.path.split('.').last;

        final newName = '${DateTime.now().millisecondsSinceEpoch}.$ext';

        final newPath = '${dir.path}/$newName';
        picker.saveTo(newPath);

        final bytes = await picker.readAsBytes();
        final image = await decodeImageFromList(bytes);

        list.add(
          Photo(
            path: newPath,
            name: newName,
            width: image.width,
            height: image.height,
            bytes: bytes,
          ),
        );
        update();
      }
    });
  }

  Future<void> delete(Photo photo) async {
    await File(photo.path).delete();
    list.remove(photo);

    update();
  }
}

class Photo {
  String path;
  String name;
  int width;
  int height;
  Uint8List bytes;

  Photo({
    required this.path,
    required this.name,
    required this.width,
    required this.height,
    required this.bytes,
  });

  int get fileSize => bytes.length;
}
