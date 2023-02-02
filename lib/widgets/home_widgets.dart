import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/pages/PageNewDetail.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import '../models/New.dart';

Widget swiperNews(Section section){
  return Observer(builder: (value){
    if(section.getList.isEmpty){
      return const Text('No hay Noticias disponibles');
    }else{
      return SizedBox(
        width: double.infinity,
        height: 250,
        child: Observer(builder: (value) => Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>  PageNewDetail(new_: New(
                    section.getList[index].idNew,
                    section.getList[index].username,
                    section.getList[index].category,
                    section.getList[index].title,
                    section.getList[index].publicationDate,
                    section.getList[index].description,
                    section.getList[index].imageUrl)
                )
                )
                )
              },
              child: Card(
                child: Column(
                  children: [
                    renderImageNew(section, index),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(section.getList[index].title!)
                  ],
                ),
              ),
            );
          },
          itemCount: section.getList.length,
          viewportFraction: 0.6,
          scale: 0.9,
        )
        )
      );
    }
  });
}

Widget swiperEvent(Section section){
return Observer(builder: (value){
  if(section.getListEvent.isEmpty){
    return const Text('No hay Eventos disponibles');
  }else{
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Observer(builder: (value) => Swiper(
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){ print(index); },
            child: Card(
              child: Column(
                children: [
                  renderImageEvent(section, index),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(section.getListEvent[index].title!)
                ],
              ),
            ),
          );
        },
        itemCount: section.getListEvent.length,
        viewportFraction: 0.9,
        scale: 0.9,
        control: const SwiperControl(),
      )
      )
    );
  }
});
}

Widget renderImageNew(Section section, int index){
  if (section.getList[index].imageUrl == null){
    return Image.asset('assets/Loading_icon.gif', height: 200);
  }else{
    return Image.network(section.getList[index].imageUrl!, fit: BoxFit.fill, height: 200, width: 300);
  }
}

Widget renderImageEvent(Section section, int index){
  if (section.getListEvent[index].imageUrl == null){
    return Image.asset('assets/Loading_icon.gif', height: 200);
  }else{
    return Image.network(section.getListEvent[index].imageUrl!, fit: BoxFit.fill, height: 200, width: 400);
  }
}

