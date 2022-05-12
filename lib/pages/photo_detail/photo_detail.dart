import 'package:album/pages/home/controller.dart';
import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  final Photo photo;

  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Detail'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.memory(
                photo.bytes,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Image name : ${photo.name}'),
                  Text('Image width : ${photo.width} px'),
                  Text('Image height : ${photo.height} px'),
                  Text('Image size : ${(photo.bytes.length / 1024).toStringAsFixed(2)}KB'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
