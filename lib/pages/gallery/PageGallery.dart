import 'package:etno_app/models/Image.dart';
import 'package:etno_app/pages/gallery/PageGalleryView.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/section.dart';

class PageGallery extends StatefulWidget {
  const PageGallery({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageGallery> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllImageMediaByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Galería', Icons.language, () => null),
      body: Column(
        children: [
          const WarningWidgetValueNotifier(),
           Observer(builder: (context){
                if(section.getImages.isNotEmpty){
                  return Expanded(child: gridGallery(section.getImages, context));
                }else{
                  return
                     Container(
                       height: 550.0,
                       alignment: Alignment.center,
                       child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisSize: MainAxisSize.min,
                           children: const [
                             Icon(Icons.block, size: 120.0),
                             Text('No hay fotos para mostrar')
                           ]
                       ),
                     );
                }
              })

        ],
      )
    );
  }
}

Widget gridGallery(List<ImageMedia> imageMediaList, BuildContext context){
  return GridView.count(
    shrinkWrap: true,
      crossAxisCount: 3,
      children: imageMediaList.map((e) =>
        Center(
          child: SizedBox(
            child: InkWell(
              onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>  PageGalleryView(imageMedia: e), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)),
                child: Card(
                  child: Image.network(e.link!, fit: BoxFit.fill, width: 120.0, height: 120.0)
                ),
            ),
          )
        )
      ).toList()
  );
}