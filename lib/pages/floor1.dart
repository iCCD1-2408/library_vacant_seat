import 'package:flutter/material.dart';
import 'package:library_vacant_seat/components/seat_service.dart';
import 'package:library_vacant_seat/components/responsive_layout.dart';

class Floor1Page extends StatelessWidget {
  const Floor1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      SeatPage(
        mapImage: Image.asset('assets/map_floor1.png'),
        apiUrl: "https://example.com",
        seatBlocks: const []
      )
    );
  }
}