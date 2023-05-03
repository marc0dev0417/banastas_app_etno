import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/Globals.dart';

class PageQuiz extends StatefulWidget {
  const PageQuiz({super.key});

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<PageQuiz>{
  final Section section = Section();
  bool? check1 = false, check2 = true, check3 = false;
  String? answer;
  String dni = '';
  bool isValid = false;
  int option = 0;

 bool isDNIValid(String input) {
   final dniRegExp = RegExp(r'^(\d{8})([A-Z])$');
   return dniRegExp.hasMatch(input);
 }

 @override
  void initState() {
    section.getQuiz('${Globals.locality}');
    super.initState();
  }

  @override
  Widget build(BuildContext pageContext) {
    return MaterialApp(
      title: 'Quiz Page',
      home: Scaffold(
        appBar: appBarCustom(context, true, AppLocalizations.of(pageContext)!.section_quiz, Icons.language, false, () => null),
        body: SafeArea(
          child: Observer(builder: (context){
            if (section.getQuizzes.isNotEmpty){
             return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Icon(Icons.quiz, size: 50.0),
                            Text(section.getQuizzes[0].question!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                          ]
                      ),
                      const Divider(thickness: 1.0),

                      Visibility(
                        visible: section.getQuizzes[0].answerOne == '' ? false : true,
                          child: RadioListTile(
                        title: Text('${section.getQuizzes[0].answerOne}'),
                        value: "1",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                        visible: section.getQuizzes[0].answerTwo == '' ? false : true,
                          child: RadioListTile(
                        title: Text('${section.getQuizzes[0].answerTwo}'),
                        value: "2",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                        visible: section.getQuizzes[0].answerThree == '' ? false : true,
                          child: RadioListTile(
                        title: Text('${section.getQuizzes[0].answerThree}'),
                        value: "3",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                          visible: section.getQuizzes[0].answerFour == '' ? false : true,
                          child: RadioListTile(
                        title: Text('${section.getQuizzes[0].answerFour}'),
                        value: "4",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      const SizedBox(height: 16.0),
                      Text(AppLocalizations.of(pageContext)!.identification, style: TextStyle(color: Colors.red)),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'DNI'
                        ),
                        onChanged: (value) => setState(() {
                          dni = value;
                        }),
                      ),
                      ElevatedButton(onPressed: () {
                        if (isDNIValid(dni)) {
                          section.sendResultQuiz('${Globals.locality}', section.getQuizzes[0].idQuiz!, int.parse(answer!));
                        } else {
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(pageContext)!.invalid_dni,
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 12,
                              textColor: Colors.white,
                              backgroundColor: Colors.red
                          );
                        }
                      }, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: Text(AppLocalizations.of(pageContext)!.vote))
                    ],
                  )
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(pageContext)!.no_quiz, style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.quiz, size: 50.0)
                    ]
                ),
              );
            }
          })
        ),
      ),
    );
  }
}