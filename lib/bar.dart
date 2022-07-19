import 'package:flutter/material.dart';
import 'package:sipsd/config.dart';
import 'package:sipsd/home.dart';
import 'package:sipsd/chat.dart';
import 'package:sipsd/notif.dart';

class Bar extends StatefulWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  int _currentIndex = 0;
  String _currentTitle = "SIPSD";

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _currentTitle = Config.navigationBarItems[_currentIndex].label.toString();
    });
  }

  @override
  void initState() {
    _currentTitle = Config.navigationBarItems[_currentIndex].label.toString();
    super.initState();
  }

  final pages = [
    const HomePage(),
    const ChatPage(),
    const NotifPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.people_sharp,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              color: Colors.red,
              child: const Text(
                "SIPSD",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 30,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: Config.navigationBar.items,
        type: Config.navigationBar.type,
        backgroundColor: Config.navigationBar.backgroundColor,
        selectedItemColor: Config.navigationBar.selectedItemColor,
        unselectedItemColor: Config.navigationBar.unselectedItemColor,
        selectedFontSize: Config.navigationBar.selectedFontSize,
        unselectedFontSize: Config.navigationBar.unselectedFontSize,
        onTap: _onTap,
      ),
    );
  }
}
