import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class FolderContain extends StatefulWidget {
  const FolderContain({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  State<FolderContain> createState() => _FolderContainState();
}

class _FolderContainState extends State<FolderContain> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
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
              child: Text(
                widget.path.split("/").last,
                style: const TextStyle(
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
                  child: FutureBuilder<List<SongInfo>>(
                    future: audioQuery.getSongs(),
                    builder: (context, item){
                      if(item.data == null){
                        return const Center(child: CircularProgressIndicator());
                      }
                      if(item.data!.isNotEmpty){
                        for(int i=0; i < item.data!.length; i++){
                          if(item.data![i].filePath.contains(widget.path)){
                            songs.add(item.data![i]);
                          }
                        }
                        return ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) => MusicItemView(songs: songs, index: index),
                        );
                      }
                      return Container();
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

