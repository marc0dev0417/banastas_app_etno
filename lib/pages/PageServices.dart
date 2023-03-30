import 'package:etno_app/main.dart';
import 'package:etno_app/pages/PageServicesList.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';

class PageServices extends StatefulWidget {
  const PageServices({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageServices> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Page services',
      home: Scaffold(
          appBar: appBarCustom(context, true, 'Servicios', Icons.language, () => null),
          body: SafeArea(
              child: Column(
                  children: [
                    const WarningWidgetValueNotifier(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
                          scrollDirection: Axis.vertical,
                          children: [
                            cardService('Servicio', 'tool_image.jpg', () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServicesList(locality: 'Bolea', category: 'Servicio'), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }),
                            const SizedBox(height: 10.0),
                            cardService('Salud', 'salud_image.jpg', (){ Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServicesList(locality: 'Bolea', category: 'Salud'), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }),
                            const SizedBox(height: 10.0),
                            cardService('Ocio', 'ocio_image.jpg', (){ Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServicesList(locality: 'Bolea', category: 'Ocio'), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); })
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          )
      ),
    );
  }
}

Widget cardService(String type, String assetImage, Function() function){
  return InkWell(
    onTap: function,
    child: Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/$assetImage'), fit: BoxFit.fill)
      ),
      child: Card(
        elevation: 5.0,
        color: Colors.transparent,
        child: Center(
          child: Text(type, style: const TextStyle(color: Colors.white, fontSize: 25.0)),
        )
      ),
    ),
  );
}