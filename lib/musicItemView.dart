import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/musicPlayer.dart';
import 'app_data.dart';

class MusicItemView extends StatefulWidget {
  MusicItemView({Key? key, required this.songs, required this.index}) : super(key: key);
  List<SongInfo> songs;
  int index = 0 ;
  @override
  State<MusicItemView> createState() => _MusicItemViewState();
}

class _MusicItemViewState extends State<MusicItemView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ListTile(
        leading: (widget.songs[widget.index].albumArtwork == null) ?
        Container(
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
        ):
        const Image(image: AssetImage("assets/Girl.webp")),
        title: Text(widget.songs[widget.index].title, overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: Text(widget.songs[widget.index].artist, overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300)),
        trailing: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
        ),
        onTap: ()=>versPlayer(widget.songs[widget.index]),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
  void versPlayer(SongInfo song){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
       return musicPlayer(songs: widget.songs, index: widget.index,);
    }));
  }
}


