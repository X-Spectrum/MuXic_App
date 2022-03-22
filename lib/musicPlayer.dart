// ignore_for_file: prefer_const_constructors, camel_case_types

/*import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import 'app_data.dart';
import 'musicItemView.dart';

class musicPlayer extends StatefulWidget {
  musicPlayer({Key? key, required this.songs, required this.index}) : super(key: key);
  List<SongInfo> songs;
  int index;

  @override
  State<musicPlayer> createState() => _musicPlayerState();
}

class _musicPlayerState extends State<musicPlayer> {
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '00:00', endTime = '00:00';
  bool isPlaying = false;
  final AudioPlayer player = AudioPlayer();

  void initState() {
    super.initState();
    setSong(widget.songs[widget.index]);
  }

  void dispose() {
    super.dispose();
    player.dispose();
  }

  void setSong(SongInfo songInfo) async {
    widget.songs[widget.index] = songInfo;
    await player.setUrl(widget.songs[widget.index].uri);
    currentValue = minimumValue;
    maximumValue = player.duration!.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);
    });
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentValue);
      });
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

  Widget slider() {
    return Slider.adaptive(
      activeColor: thirdColor,
      inactiveColor: secondColor,
      min: minimumValue,
      max: maximumValue,
      value: currentValue,
      onChanged: (value) {
        currentValue = value;
        player.seek(Duration(milliseconds: currentValue.round()));
      },
    );
  }
  void changeTrack(bool isNext) {
    if (isNext) {
      if (widget.index != widget.songs.length - 1) {
        setState(() {
          widget.index++;
        });
      }
    } else {
      if (widget.index != 0) {
        setState(() {
          widget.index--;
        });
      }
    }
    setSong(widget.songs[widget.index]);
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
                          child: const Icon(
                            Icons.music_note_rounded,
                            color: Colors.grey,
                            size: 100,)
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
                              widget.songs[widget.index].artist,
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
                        icon: Icon(Icons.loop_rounded),
                        onPressed: (){},
                        iconSize: 35,
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous_rounded),
                        onPressed: (){
                          changeTrack(false);
                        },
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
                        onPressed: ()=>changeTrack(true),
                        iconSize: 35,
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: Icon(Icons.shuffle_rounded),
                        onPressed: (){},
                        iconSize: 35,
                        color: Colors.white,
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