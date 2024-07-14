import 'package:flutter/material.dart';
import 'package:library_vacant_seat/constants.dart';
import 'package:library_vacant_seat/util/my_box.dart';
import 'package:library_vacant_seat/util/my_tile.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myDefaultBackground,
      drawer: myDrawer,
      body: Column(children: [
        // 4 boxes on the top
        AspectRatio(
          aspectRatio: 1,
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
        return MyTile();
          },
         ),
        )
       ],
      ),
    );
  }
}
