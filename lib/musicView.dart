import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';
//import 'package:permission_handler/permission_handler.dart';

class MusicListView extends StatefulWidget {
  const MusicListView({Key? key}) : super(key: key);

  @override
  State<MusicListView> createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Permission.storage.request();
  }
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  @override
  Widget build(BuildContext context) {
    //return Container();
    return FutureBuilder<List<SongInfo>>(
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
        itemCount: item.data!.length,);
      }
    );
  }
}
