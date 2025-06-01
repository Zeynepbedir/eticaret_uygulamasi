import 'package:eticaret_uygulamasi/ui/screen/anasayfa.dart';
import 'package:eticaret_uygulamasi/ui/screen/favori.dart';
import 'package:eticaret_uygulamasi/ui/screen/sepet.dart';
import 'package:flutter/material.dart';

class AltMenu extends StatefulWidget {
  const AltMenu({super.key});

  @override
  State<AltMenu> createState() => _AltMenuState();
}

class _AltMenuState extends State<AltMenu> {
  int selectIndex = 0;
  static const List<Widget> pages = <Widget>[
    const Anasayfa(),
    const Favori(),
    const Sepet(),
  ];

  void secilen(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectIndex], // Seçilen sayfayı göster
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: secilen,
        backgroundColor: Color(0xFFF8F4EC), // Açık bej arkaplan
        selectedItemColor: const Color(0xFFBE4C2A), // Kiremit seçili
        unselectedItemColor: const Color(0xFF5F7589),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sepet',
          ),
        ],
      ),
    );
  }
}
