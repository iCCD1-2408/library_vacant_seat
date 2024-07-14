import 'package:flutter/material.dart';

var myDefaultBackground = Colors.white;

var myAppBar = AppBar(
  backgroundColor: Colors.grey[400],
  title: const Text('S E A T   V A C A N C Y'),
);

var myDrawer = Drawer(
        backgroundColor: Colors.grey[200],
        child: const Column(
          children:[
          DrawerHeader(child: Icon(Icons.favorite),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('H O M E'),
          ),
          ListTile(
            leading: Icon(Icons.stairs_rounded),
            title: Text('F L O O R   3'),
          ),
           ListTile(
            leading: Icon(Icons.stairs_rounded),
            title: Text('F L O O R   2'),
          ),
           ListTile(
            leading: Icon(Icons.stairs_rounded),
            title: Text('F L O O R   1'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('S E T T I N G S'),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('L O G O U T'),
          ),
        ],
       ),
      );