import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;

class SeatPage extends StatefulWidget {
  final Image mapImage;
  final String apiUrl;
  final List<SeatBlock> seatBlocks;

  const SeatPage({super.key, required this.mapImage, required this.apiUrl, required this.seatBlocks });

  @override
  State<SeatPage> createState() => SeatPageState();
}

class SeatPageState extends State<SeatPage> {
  final Map<int, bool> _seatStatus = {};
  bool _isLoaded = false;

  Map<int, bool> get seatStatus => _seatStatus;
  bool get isLoaded => _isLoaded;

  Future<void> updateSeatStatus() async {
    try {
      /*
      final response = await http.get(Uri.parse(widget.apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, String>> json = jsonDecode(response.body);

        _seatStatus.clear();
        for (var j in json) {
          _seatStatus[j["id"] as int] = j["is_vacant"] as bool;
        }
      } else {
        log('Failed to update seat status: ${response.statusCode}', name: 'SeatAvailabilityService');
      }
      */

      var random = math.Random();
      String data = '[{"id": 0, "is_vacant": ${random.nextBool()}}';
      for (int i = 1; i < 100; i++) {
        data += ',{"id": $i, "is_vacant": ${random.nextBool()}}';
      }
      data += ']';
      List<dynamic> json = jsonDecode(data);

      _seatStatus.clear();
      for (var j in json) {
        _seatStatus[j["id"] as int] = j["is_vacant"] as bool;
      }

      for (var block in widget.seatBlocks) {
        GlobalKey<SeatBlockState> key = block.key as GlobalKey<SeatBlockState>;
        key.currentState?.fetchVacancy(_seatStatus);
      }
      await Future.delayed(const Duration(seconds: 5));
      setState(() {});
    } catch (e) {
      log('Error updating seat status: $e', name: 'SeatAvailabilityService');
    }
    _isLoaded = true;
  }

  @override
  void initState() {
    super.initState();
    updateSeatStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              updateSeatStatus();
            });
          },
          child: const Text('Update'),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            widget.mapImage,
            for (var block in widget.seatBlocks) block,
          ]
        )
      ],
    );
  }
}

class SeatBlock extends StatefulWidget {
  final SeatBlockPainter _painter = SeatBlockPainter();
  final double left, top, right, bottom;
  late final double width = right - left + 1, height = bottom - top + 1;
  final int detailMagnification;

  late final List<SeatInfo> _seats;
  get seats => _seats;

  SeatBlock({required super.key, required this.left, required this.top,
      required this.right, required this.bottom, required List<SeatInfo> seats, this.detailMagnification = 2}) {
    _seats = seats;
  }

  @override
  State<SeatBlock> createState() => SeatBlockState();
}
class SeatBlockState extends State<SeatBlock> {
  int _vacantCount = 0;

  void fetchVacancy(Map<int, bool> seatStatus) {
    setState(() {
      _vacantCount = 0;
      for (var seat in widget._seats) {
        bool isVacant = seatStatus[seat.id] ?? false;
        seat.updateVacancy(isVacant);
        if (isVacant) _vacantCount++;
      }
    });
  }

  void _handleHover(PointerHoverEvent event) {
    setState(() {
      widget._painter.isHovered = true;
    });
  }

  void _handleHoverExit(PointerExitEvent event) {
    setState(() {
      widget._painter.isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 0,
      top: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var alignX = widget.left / (1611.0 - widget.width) * 2.0 - 1.0;
          var alignY = widget.top / (1115.0 - widget.height) * 2.0 - 1.0;
          var size = Size(
            widget.width * constraints.maxWidth / 1611.0,
            widget.height * constraints.maxHeight / 1115.0
          );
          var fontSize = math.min(20, (constraints.maxHeight * 0.03).floor()).toDouble();

          return Align(
            alignment: Alignment(alignX, alignY),
            child: MouseRegion(
              onHover: _handleHover,
              onExit: _handleHoverExit,
              child: GestureDetector(
                onTap: () => _showDialog(context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(painter: widget._painter, size: size),
                    Text(
                      '$_vacantCount/${widget._seats.length}',
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                  ]
                )
              )
            )
          );
        }
      )
    );
  }

  void _showDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: buildDialog
    );
  }

  Widget buildDialog(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            var isVertical = constraints.maxWidth < constraints.maxHeight;
            var seatSize = 10.0 * widget.detailMagnification;
            var vacantPainter = SeatDetailPainter(seatSize, true);
            var fullPainter = SeatDetailPainter(seatSize, false);

            return SingleChildScrollView(
              scrollDirection: isVertical ? Axis.horizontal : Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Area Details', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  Container(
                    width: widget.width * widget.detailMagnification,
                    height: widget.height * widget.detailMagnification,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Stack(
                      children: [
                        for (var seat in widget._seats)
                          Positioned(
                            left: seat.x * widget.detailMagnification,
                            top: seat.y * widget.detailMagnification,
                            child: CustomPaint(painter: seat.isVacant ? vacantPainter : fullPainter)
                          )
                      ]
                    )
                  )
                ],
              )
            );
          }
        )
      ),
    );
  }
}
class SeatBlockPainter extends CustomPainter {
  bool isHovered = false;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, isHovered ? 0.4 : 0.6);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(SeatBlockPainter oldDelegate) {
    return oldDelegate.isHovered != isHovered;
  }
}
class SeatDetailPainter extends CustomPainter {
  final double size;
  final bool isVacant;

  SeatDetailPainter(this.size, this.isVacant);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isVacant ? Colors.green : Colors.red;
    canvas.drawRect(Rect.fromLTWH(0, 0, this.size.toDouble(), this.size.toDouble()), paint);
  }

  @override
  bool shouldRepaint(SeatDetailPainter oldDelegate) => false;
}


class SeatInfo {
  final int id;
  final double x;
  final double y;
  bool isVacant = false;

  SeatInfo({required this.id, required this.x, required this.y});

  void updateVacancy(bool isVacant) {
    this.isVacant = isVacant;
  }
}