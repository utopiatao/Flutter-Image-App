import 'dart:io';

import 'package:album/pages/home/controller.dart';
import 'package:album/pages/photo_detail/photo_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AlbumController());
    return GetBuilder<AlbumController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Album'),
        ),
        body: Column(
          children: [
            Flexible(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1,
                children: [
                  for (final photo in controller.list)
                    InkWell(
                      onTap: () => Get.to(PhotoDetail(photo: photo)),
                      onLongPress: () => controller.delete(photo),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          photo.bytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                OutlinedButton(
                  onPressed: () => controller.add(isCamera: false),
                  child: const Text('Add from local'),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                ElevatedButton(
                  onPressed: () => controller.add(isCamera: true),
                  child: const Text('Add from camera'),
                ),
                const SizedBox(width: 30),
              ],
            )
          ],
        ),
      ),
    );
  }
}
