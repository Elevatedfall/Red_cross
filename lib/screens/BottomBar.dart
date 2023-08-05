import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Activity.dart';
import 'announcement.dart';
import 'homepage.dart';

class BottomBar extends StatefulWidget {
  final String branchName;
  const BottomBar({required this.branchName, Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedindex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(),
      AnnouncementPage(branchName: widget.branchName),
      ActivityPage(subBranchId: widget.branchName),
    ];
  }

  void _onitemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedindex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: _onitemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_16_regular),
            activeIcon: Icon(FluentIcons.home_16_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.speaker_0_16_regular),
            activeIcon: Icon(FluentIcons.speaker_0_16_filled),
            label: "Announcements",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.broad_activity_feed_16_regular),
            activeIcon: Icon(FluentIcons.broad_activity_feed_16_filled),
            label: "Activities",
          ),
        ],
      ),
    );
  }
}
