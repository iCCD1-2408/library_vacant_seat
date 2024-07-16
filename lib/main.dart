import 'package:flutter/material.dart';
import 'package:library_vacant_seat/components/responsive_layout.dart';
import 'package:library_vacant_seat/pages/floor3.dart';
import 'package:library_vacant_seat/pages/floor2.dart';
import 'package:library_vacant_seat/pages/floor1.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/floor3': (context) => const Floor3Page(),
      '/floor2': (context) => const Floor2Page(),
      '/floor1': (context) => const Floor1Page(),
      //'/bottom_navigation_bar_screen': (context) => const BottomNavigationBarScreen(),
      //'/drawer_screen': (context) => const DrawerScreen(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      Column(
        children: [
          Text(
            'This is Home!',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center
          )
        ]
      )
    );
  }
}