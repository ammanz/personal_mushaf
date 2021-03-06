import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_mushaf/src/mixins/navigation_mixins/classic_madani_15_nav.dart';
import 'package:personal_mushaf/src/mixins/string_resource_mixins/classic_madani_15_strings.dart';
import 'package:personal_mushaf/src/screens/quran_viewer.dart';
import 'package:personal_mushaf/src/widgets/navigation_tab.dart';

class NavigationPagerScreen extends StatefulWidget {
  NavigationPagerScreen({Key key}) : super(key: key);

  @override
  _NavigationPagerScreenState createState() => _NavigationPagerScreenState();
}

class _NavigationPagerScreenState extends State<NavigationPagerScreen> {
  final List<String> tabTitles = ['JUZ', 'SURAH'];

  @override
  Widget build(BuildContext context) {
    final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Color.fromRGBO(50, 53, 58, 1),
        statusBarColor: Color.fromRGBO(50, 53, 58, 1));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: DefaultTabController(
        length: 2,
        child: ColorfulSafeArea(
          color: Color.fromRGBO(35, 38, 41, 1),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(50, 53, 58, 1),
              brightness: Brightness.dark,
              title: Text(
                'Qur\'an Contents',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              bottom: ColoredTabBar(
                Color.fromRGBO(35, 38, 41, 1),
                TabBar(
                  indicatorColor: Colors.white,
                  tabs: tabTitles
                      .map((title) => Tab(
                            text: title,
                          ))
                      .toList(),
                ),
              ),
              actions: <Widget>[
                PopupMenuTheme(
                  data: PopupMenuThemeData(
                      color: Color.fromRGBO(50, 53, 58, 1),
                      textStyle: TextStyle(color: Colors.white)),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {},
                    itemBuilder: (BuildContext context) {
                      return {'Settings'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              choice,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                NavigationTab(
                  prefixes: juzNames,
                  lengths: ClassicMadani15Nav.juzLengths,
                  pageNumbers: ClassicMadani15Nav.juzPageNumbers,
                  onTap: (int index) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuranViewer(
                              initialPage: index,
                            )));
                  },
                ),
                NavigationTab(
                  prefixes: surahNamesArabic,
                  lengths: ClassicMadani15Nav.surahLengths,
                  pageNumbers: ClassicMadani15Nav.surahPageNumbers,
                   onTap: (int index) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuranViewer(
                              initialPage: index,
                            )));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: Material(
          type: MaterialType.transparency,
          child: tabBar,
        ),
      );
}
