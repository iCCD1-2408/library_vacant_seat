import 'package:flutter/material.dart';
import 'package:library_vacant_seat/components/seat_service.dart';
import 'package:library_vacant_seat/components/responsive_layout.dart';

class Floor3Page extends StatelessWidget {
  const Floor3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      SeatPage(
        mapImage: Image.asset('assets/map_floor3.png'),
        apiUrl: "https://example.com",
        seatBlocks: [
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 625,
            top: 192,
            right: 965,
            bottom: 319,
            seats: [
              for (int i = 0; i < 48; i++)
                SeatInfo(id: i, x: 14 + (i % 12) * 30, y: 12 + (i / 12).floor() * 30),
            ]
          ),
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 594,
            top: 84,
            right: 929,
            bottom: 160,
            seats: [
              for (int i = 0; i < 22; i++)
                SeatInfo(id: 48 + i, x: 12 + (i % 11) * 30, y: 16 + (i / 11).floor() * 30),
            ]
          ),
          SeatBlock(
            key: GlobalKey<SeatBlockState>(),
            left: 443,
            top: 373,
            right: 625,
            bottom: 493,
            seats: [
              for (int i = 0; i < 24; i++)
                SeatInfo(id: 70 + i, x: 20 + (i % 4) * 30, y: 9 + (i / 4).floor() * 18),
            ]
          ),
        ],
      )
    );
  }
}