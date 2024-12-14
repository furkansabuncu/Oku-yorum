import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterprojem/common/paths.dart';
import 'package:flutterprojem/features/browse/views/browse.dart';
import 'package:flutterprojem/features/dashboard/views/dashboard.dart';
import 'package:flutterprojem/features/more/view/more.dart';
import 'package:flutterprojem/features/profile/views/profile.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> list = [
    const Browse(),
    const More(),
    const Profile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              newHomeSvg,
            ),
            activeIcon: SvgPicture.asset(
              newHomeSvg,
            ),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              activitySvg,
            ),
            activeIcon: SvgPicture.asset(
              activitySvg,
            ),
            label: "Aktivite",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              newProfileSvg,
            ),
            activeIcon: SvgPicture.asset(
              newProfileSvg,
            ),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}