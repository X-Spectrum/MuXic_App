import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({Key? key}) : super(key: key);

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: const Text(
                "Favoris",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: const BoxDecoration(
                color: secondColor,
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: const Text(
                    "Favoris",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}