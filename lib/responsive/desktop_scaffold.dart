import 'package:flutter/material.dart';
import 'package:library_vacant_seat/constants.dart';
import 'package:library_vacant_seat/util/my_box.dart';
import 'package:library_vacant_seat/util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: myAppBar,
      body: Row(children: [
        //open drawer
        myDrawer,

        // rest of body
        Expanded(
           flex: 4,
          child: Column(children: [
        // 4 boxes on the top
        AspectRatio(
          aspectRatio: 4,
          child: SizedBox(
            width: double.infinity,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                ), 
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
        ), 
      ],
      )
    ),
      Expanded(
          child: Column(
            children: [
          Expanded(child: Container(color: Colors.grey[300])),
          ],
         ),
        )
       ],
      ),
     );
   }
}