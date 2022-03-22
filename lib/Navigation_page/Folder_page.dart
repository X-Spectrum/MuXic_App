import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class FolderListPage extends StatefulWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
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
                "Dossiers",
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
                    "Dossiers",
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