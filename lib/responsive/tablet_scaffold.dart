import 'package:flutter/material.dart';
import 'package:library_vacant_seat/constants.dart';
import 'package:library_vacant_seat/util/my_box.dart';
import 'package:library_vacant_seat/util/my_tile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: myAppBar,
      drawer: myDrawer,
      body: Column(children: [
        // 4 boxes on the top
        AspectRatio(
          aspectRatio: 4,
          child: SizedBox(
            width: double.infinity,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1), 
              itemBuilder: (context, index){
              return const MyBox();
            },
            ),
          ),
        ),
        // tiles below it
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index){
        return const MyTile();
          },
         ),
        )
       ],
      ),
    );
  }
}