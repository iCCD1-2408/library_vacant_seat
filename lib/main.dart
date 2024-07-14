import 'package:flutter/material.dart';
import 'package:library_vacant_seat/responsive/desktop_scaffold.dart';
import 'package:library_vacant_seat/responsive/mobile_scaffold.dart';
import 'package:library_vacant_seat/responsive/responsive_layout.dart';
import 'package:library_vacant_seat/responsive/tablet_scaffold.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
      mobileScaffold: const MobileScaffold(),
      tabletScaffold: const TabletScaffold(),
      desktopScaffold: const DesktopScaffold(),
      ),
    );
  }
}

