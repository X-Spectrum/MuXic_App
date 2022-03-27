// ignore_for_file: prefer_const_constructors, camel_case_types

/*import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';*/
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'app_data.dart';
import 'musicItemView.dart';

class musicPlayer extends StatefulWidget {
  musicPlayer({Key? key, required this.songs, required this.index, required this.player}) : super(key: key);
  List<SongModel> songs;
  int index;
  AudioPlayer player;

  @override
  State<musicPlayer> createState() => _musicPlayerState();
}

class _musicPlayerState extends State<musicPlayer> {
  double minimumValue = 0.0, maximumValue = .0, currentValue = 0.0;
  String currentTime = '00:00', endTime = '00:00';
  Widget artworkAudio = Icon(Icons.music_note_rounded);
  ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: []);
  bool isPlaying = false;
  List<IconData> repeatIcons = [Icons.repeat, Icons.repeat_one];
  int loopType=0;
  bool checkModalSheet = false;
  AudioPlayer player = AudioPlayer();

  void initState() {
    super.initState();
    setSong();
    setArtwork();
  }

  void setArtwork(){
    artworkAudio = QueryArtworkWidget(
      id: widget.songs[widget.index].id,
      type: ArtworkType.AUDIO,
      nullArtworkWidget: const Icon(
        Icons.music_note_rounded,
        color: Colors.grey,
        size: 100,),
      artworkBorder: BorderRadius.circular(30.0),
    );
  }

  void dispose() {
    super.dispose();
  }

  void setSong() async {
    player = widget.player;

    for (int i=0; i<widget.songs.length; i++ ){
      playlist.add(AudioSource.uri(Uri.parse(widget.songs[i].uri.toString())));
    }
    await player.setAudioSource(playlist);
    await player.seek(Duration(milliseconds: 0), index: widget.index);

    currentValue = minimumValue;
    maximumValue = player.duration!.inMilliseconds.toDouble();
    currentTime = getDuration(currentValue);
    endTime = getDuration(maximumValue);
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue = duration.inMilliseconds.toDouble() ;
      setState(() {
        currentTime = getDuration(currentValue);
        endTime = getDuration(maximumValue);
      });
      if(player.currentIndex != widget.index){
        updateDuration();
        setState(() {
          widget.index = player.currentIndex!;
          setArtwork();
        });
      }
    });
  }

  void updateDuration(){
    currentValue = minimumValue;
    maximumValue = player.duration!.inMilliseconds.toDouble();
    setState(() {
      endTime = getDuration(maximumValue);
    });
  }



  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void seek(int index) async{
    await player.seek(Duration(milliseconds: 0), index: widget.index);
    updateDuration();
  }

  Widget slider() {
    return Slider.adaptive(
      activeColor: thirdColor,
      inactiveColor: secondColor,
      min: minimumValue,
      max: maximumValue,
      value: currentValue,
      onChanged: (value) {
        currentValue = value;
        if(player.currentIndex != widget.index){
          updateDuration();
          setState(() {
            widget.index = player.currentIndex!;
            setArtwork();
          });
        }
        player.seek(Duration(milliseconds: currentValue.round()));
      },
    );
  }

  void seekToNext()async{
    if (player.hasNext){
      await player.seekToNext();
      updateDuration();
      setState(() {
        widget.index = player.currentIndex!;
        setArtwork();
      });
    }
  }

  void seekToPrevious()async{
    if (currentValue >= minimumValue + 3000.0){
      await player.seek(Duration(milliseconds: 0), index: widget.index);
    }else {
      if (player.hasNext) {
        await player.seekToPrevious();
        updateDuration();
        setState(() {
          widget.index = player.currentIndex!;
          setArtwork();
        });
      }
    }
  }

  void _showModalBottomSheet(BuildContext context){
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,

      /*enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
      ),*/
      context: context,
      builder: (context){
        return Container(
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30),),
            color: firstColor
          ),
          child: ListView.builder(
              itemCount: widget.songs.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: ListTile(
                  leading: QueryArtworkWidget(
                    id: widget.songs[index].id,
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
                    artworkBorder: BorderRadius.circular(15),
                    artworkWidth: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
                    artworkHeight: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
                  ),
                  title: Text(widget.songs[index].title, overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                  subtitle: Text(widget.songs[index].artist ?? "Inconnu", overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300)),
                  trailing: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    setState(() {
                      widget.index = index;
                    });
                    seek(index);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              )
            ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: firstColor,
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed:(){
                    if(isPlaying){
                      //player.stop();
                      Navigator.pop(context);
                    }else{
                      Navigator.pop(context);
                    }
                  },
                ),
                centerTitle: true,
                backgroundColor: firstColor,
                elevation: 0,
                floating: true,
                title: Text(
                  'Lecteur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: IconButton(
                      onPressed: (){},
                      splashRadius: 28.0,
                      splashColor: secondColor,
                      icon: Icon(
                        Icons.more_vert_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 15.0, bottom: 25.0),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: MediaQuery.of(context).size.height / 2.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: secondColor,
                          ),
                          child: artworkAudio,
                      ),
                      /*Container(
                        margin: EdgeInsets.only(top: 15.0, bottom: 25.0),
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: MediaQuery.of(context).size.height / 2.7,
                        decoration: BoxDecoration(
                          color: secondColor,
                          borderRadius: BorderRadius.circular(30.0)
                          ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: AspectRatio(
                            aspectRatio: 1.25,
                            child: Image(
                              image: AssetImage("assets/Girl.webp"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),*/
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              widget.songs[widget.index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 7.0),
                            Text(
                              widget.songs[widget.index].artist ?? "Inconnu",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 7.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,child: slider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text(
                              endTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: (loopType == 2) ? Icon(repeatIcons[1]): Icon(repeatIcons[0]),
                        onPressed: (){
                          setState(() {
                            loopType++;
                            if(loopType>2){
                              loopType = 0;
                            }
                          });
                        },
                        iconSize: 35,
                        color: (loopType == 0) ? Colors.white: thirdColor,
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous_rounded),
                        onPressed: () => seekToPrevious(),
                        iconSize: 35,
                        color: Colors.white,
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: IconButton(
                          icon: Icon(
                            (isPlaying) ? Icons.pause : Icons.play_arrow
                            ),
                          onPressed: (){
                            changeStatus();
                          },
                          iconSize: 35,
                          splashRadius: 50,
                          color: firstColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next_rounded),
                        onPressed: () => seekToNext(),
                        iconSize: 35,
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: Icon(Icons.shuffle_rounded),
                        onPressed: (){
                          player.setShuffleModeEnabled(!player.shuffleModeEnabled);
                        },
                        iconSize: 35,
                        color: (player.shuffleModeEnabled) ? thirdColor : Colors.white,
                      )
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child : SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  child: TextButton(
                    onPressed: (){
                      _showModalBottomSheet(context);
                      checkModalSheet = true;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 10,),
                        Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white, size: 20),
                        Text(
                          "Musique",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
        )
    );
  }
}

