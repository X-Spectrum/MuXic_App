import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class SongsListPage extends StatefulWidget {
  SongsListPage({Key? key, required this.player}) : super(key: key);
  AudioPlayer player;
  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  OnAudioQuery audioQuery = OnAudioQuery();
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
                "Musiques",
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
                decoration: const BoxDecoration(
                  color: firstColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),

                child: FutureBuilder<List<SongModel>>(
                  future: audioQuery.querySongs(),
                  builder: (context, item) {
                    if (item.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                        child: Text("Aucune chanson trouvée"),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) => MusicItemView(player: widget.player, songs: item.data!, index: index,),
                      itemCount: item.data!.length,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
