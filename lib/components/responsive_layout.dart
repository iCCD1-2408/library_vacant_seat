import 'package:flutter/material.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget _innerWidget;

  const ResponsiveLayout(this._innerWidget, {super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _layoutBuilder);
  }

  Widget _layoutBuilder(BuildContext context, BoxConstraints constraints) {
    final drawer = Drawer(
      backgroundColor: Colors.grey[200],
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            const Column(
              children: [
                Icon(Icons.menu_book, size: 100),
                Text(
                  'LIBRARY\nSEAT\nVACANCY',
                  style: TextStyle( fontSize: 20, letterSpacing: 10 ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('HOME', style: TextStyle( letterSpacing: 5 )),
              onTap: () => Navigator.pushNamed(context, '/')
            ),
            ListTile(
              leading: const Icon(Icons.stairs_rounded),
              title: const Text('FLOOR 3', style: TextStyle( letterSpacing: 5 )),
              onTap: () => Navigator.pushNamed(context, '/floor3')
            ),
              ListTile(
              leading: const Icon(Icons.stairs_rounded),
              title: const Text('FLOOR 2', style: TextStyle( letterSpacing: 5 )),
              onTap: () => Navigator.pushNamed(context, '/floor2')
            ),
              ListTile(
              leading: const Icon(Icons.stairs_rounded),
              title: const Text('FLOOR 1', style: TextStyle( letterSpacing: 5 )),
              onTap: () => Navigator.pushNamed(context, '/floor1')
            ),
          ],
        ),
      ),
    );

    final isMobile = constraints.maxWidth < 500;
    final isTablet = !isMobile && constraints.maxWidth < 1100;
    final isDesktop = !isTablet;

    final double paddingX = isDesktop ? 40 : 20;
    final double paddingY = isDesktop ? 20 : 10;

    final main = Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(paddingX, paddingY, paddingX, paddingY),
        child: widget._innerWidget
      )
    );

    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text('LIBRARY SEAT VACANCY', style: TextStyle( letterSpacing: 10 )),
      ),
      backgroundColor: Colors.white,
      drawer: isDesktop ? null : drawer,
      body: isDesktop ? Row(children: [drawer, main]) : main,
    );
  }
}