import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/Navigation_page/Home_screen.dart';
import 'package:projet/Navigation_page/Song_page.dart';
import 'package:projet/musicView.dart';

import '../app_data.dart';
import '../musicItemView.dart';
import '../playlistItemView.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key, /*required this.moveToPage*/}) : super(key: key);

  //final Function(int index) moveToPage;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SongInfo> songInfo = [];
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSong();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextBox(title: "Playlist", fun: (){},),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(3, (index) => const Playlist()),
            ),
          ),
        ),
        SliverToBoxAdapter(child: TextBox(title: "Musiques", fun: (){
          //widget.moveToPage(1);
        },)),
        SliverToBoxAdapter(
          child: FutureBuilder<List<SongInfo>>(
            future: audioQuery.getSongs(),
            builder: (context, item){
              if(item.data == null){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(item.data!.isEmpty){
                return const Center(
                  child: Text(
                    "Aucune chanson trouvée",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                );
              }
              return Column(
                children: List.generate(5, (index) => MusicItemView(songs: item.data!, index: index,)),
              );
            },
          ),
        ),
      ],
    );
  }

  void toSongListPage(int index){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
       return HomeScreen();
    }));
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    Key? key,
    required this.title,
    required this.fun,
  }) : super(key: key);
  final String title;
  final VoidCallback fun;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: TextButton(
              onPressed: fun,
              child: const Text(
                'Voir plus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}