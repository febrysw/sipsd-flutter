import 'package:flutter/material.dart';

class Config {
  static List<BottomNavigationBarItem> navigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications), label: "Notif"),
  ];

  static BottomNavigationBar navigationBar = BottomNavigationBar(
    items: navigationBarItems,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.red,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    selectedFontSize: 13,
    unselectedFontSize: 11,
  );
}
