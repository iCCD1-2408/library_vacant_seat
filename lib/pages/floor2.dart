import 'package:flutter/material.dart';
import 'package:library_vacant_seat/components/seat_service.dart';
import 'package:library_vacant_seat/components/responsive_layout.dart';

class Floor2Page extends StatelessWidget {
  const Floor2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      SeatPage(
        mapImage: Image.asset('assets/map_floor2.png'),
        apiUrl: "https://example.com",
        seatBlocks: [
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 444,
            top: 88,
            right: 1066,
            bottom: 325,
            seats: [
              for (int i = 0; i < 55; i++) SeatInfo(id: i, x: 0, y: 0),
            ]
          ),
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 628,
            top: 372,
            right: 883,
            bottom: 631,
            seats: [
              for (int i = 0; i < 30; i++) SeatInfo(id: 55 + i, x: 0, y: 0),
            ]
          ),
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 444,
            top: 386,
            right: 588,
            bottom: 495,
            seats: [
              for (int i = 0; i < 16; i++) SeatInfo(id: 85 + i, x: 15 + (i % 4) * 28, y: 20 + (i / 4).floor() * 20),
            ]
          ),
        ],
      )
    );
  }
}