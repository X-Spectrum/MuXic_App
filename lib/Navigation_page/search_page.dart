import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:projet/Navigation_page/Home_page.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.player}) : super(key: key);
  AudioPlayer player;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String query="";
  List<SongModel> search = [];
  OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                    controller: _controller,
                    onChanged: (string){
                      setState(() {
                        query = string;
                      });
                    },
                    showCursor: false,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                      ),
                    )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/35,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),

                  child: (query != "") ? FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isNotEmpty) {
                        search = [];
                        for(int i=0; i < item.data!.length ; i++){
                          if (item.data![i].title.toLowerCase().contains(query.toLowerCase())){
                            search.add(item.data![i]);
                          }
                        }
                        if (search.isNotEmpty ){
                          return ListView.builder(
                            itemBuilder: (context, index) => MusicItemView(player: widget.player,songs: search, index: index,),
                            itemCount: search.length,
                          );
                        }else{
                          return const Center(
                            child: Text(
                              "Aucune chanson trouvée",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }

                      }
                      return Container();
                    },
                  ) : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height/5,
                          color: secondColor,
                        ),
                        const Text(
                          "Rechercher des chansons",
                          style: TextStyle(
                            color: secondColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
