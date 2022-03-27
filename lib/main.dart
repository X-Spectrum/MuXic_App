// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';
import 'package:projet/playlistItemView.dart';

import 'Navigation_page/Home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      home: HomeScreen(index: 0,),
      debugShowCheckedModeBanner: false,
    );
  }
}