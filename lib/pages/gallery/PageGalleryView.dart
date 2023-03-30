import 'package:etno_app/models/Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageGalleryView extends StatelessWidget {
  const PageGalleryView({super.key, required this.imageMedia});
  final ImageMedia imageMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.white24,
        body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            alignment: Alignment.center,
            child: Image.network(imageMedia.link!),
          ),
        ),
      ),
    );
  }
}