import 'package:etno_app/widgets/DropDownLanguage.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarCustom(
    BuildContext context,
    bool isVisibleBack,
    String title,
    IconData iconData,
    bool isVisibleLanguage,
    Function() action,
    [tabs]
    ){
  return AppBar(
    backgroundColor: Color.fromRGBO(255, 50, 50, 1.0),
    automaticallyImplyLeading: false,
    leading: Visibility(
      visible: isVisibleBack,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.chevron_left, color: Colors.white),
      ),
    ),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    actions:  [
      Visibility(
        visible: isVisibleLanguage,
          child: LanguagePickerWidget()
      )
    ],
  );
}

PreferredSizeWidget appBarNews(
    BuildContext context,
    String title,
    IconData iconData,
    Function() action,
    List<String> tabs
    ){

  return AppBar(
      backgroundColor: Colors.red,

      automaticallyImplyLeading: false,
      title: Text(title, style: const TextStyle(color: Colors.white)),
    bottom: TabBar(
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.black,
      isScrollable: true,
      tabs: [ for (final tab in tabs) Tab(text: tab)]
    ),
  );
}