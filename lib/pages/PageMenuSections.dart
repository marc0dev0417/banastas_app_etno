import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PageMenuSections extends StatefulWidget {
  const PageMenuSections({super.key});

  @override
  State<StatefulWidget> createState() {
      return PageState();
  }
}

class PageState extends State<PageMenuSections> {
  final sectionStore = Section();
  int bottomIndex = 3;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Container(
           padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
           child: Column(
             children: [
               Container(
                 padding: const EdgeInsets.only(left: 15.0),
                 alignment: Alignment.topLeft,
                 child: const Text('Menú', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
               ),
               Expanded(child: Observer(builder: (context) => GridView.count(
                   crossAxisCount: 3,
                   children: sectionStore.getSections.map((e) =>
                       Center(
                           child: SizedBox(
                             height: 150,
                             width: 150,
                             child: InkWell(
                               onTap: (){ print(e.title); },
                               child: Card(
                                 elevation: 10.0,
                                 shadowColor: Colors.grey,
                                 child: Center(
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Icon(e.icon),
                                         Text(e.title!, style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 10.0))
                                       ],
                                     )
                                 ),
                               ),
                             ),
                           )
                       )
                   ).toList()
               )
               ))
             ],
           )
         ),
       ),
      bottomNavigationBar: bottomNavigation(context, 3)
    );
  }
}