import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:projet/musicPlayer.dart';
import 'app_data.dart';

class MusicItemView extends StatefulWidget {
  MusicItemView({Key? key, required this.songs, required this.index, required this.player}) : super(key: key);
  List<SongModel> songs;
  int index = 0 ;
  AudioPlayer player;
  @override
  State<MusicItemView> createState() => _MusicItemViewState();
}

class _MusicItemViewState extends State<MusicItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ListTile(
        leading: QueryArtworkWidget(
          id: widget.songs[widget.index].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: Container(
              width: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
              height: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: secondColor,
              ),
              child: const Icon(
                Icons.music_note_rounded,
                color: Colors.grey,
                size: 30,)
          ),
          artworkBorder: BorderRadius.circular(15.0),
          artworkWidth: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
          artworkHeight: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,

        ),
        title: Text(widget.songs[widget.index].title, overflow: TextOverflow.ellipsis ,style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: Text(widget.songs[widget.index].artist ?? "Inconnu", overflow: TextOverflow.ellipsis ,style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300)),
        trailing: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
        ),
        onTap: ()=>versPlayer(),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
  void versPlayer(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
       return musicPlayer(player: widget.player, songs: widget.songs, index: widget.index,);
    }));
  }
}


