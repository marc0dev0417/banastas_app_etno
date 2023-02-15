import 'package:etno_app/models/Image.dart';
import 'package:flutter/cupertino.dart';

class PageGalleryView extends StatelessWidget {
  const PageGalleryView({super.key, required this.imageMedia});
  final ImageMedia imageMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.network(imageMedia.link!),
    );
  }
}