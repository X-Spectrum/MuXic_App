import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class SongsListPage extends StatefulWidget {
  const SongsListPage({Key? key}) : super(key: key);

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
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

                child: FutureBuilder<List<SongInfo>>(
                  future: audioQuery.getSongs(),
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
                      itemBuilder: (context, index) => MusicItemView(songs: item.data!, index: index,),
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
