import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:projet/Navigation_page/Favorite_page.dart';
import 'package:projet/Navigation_page/Folder_contain.dart';
import 'package:projet/Navigation_page/Folder_page.dart';
import 'package:projet/Navigation_page/Home_page.dart';
import 'package:projet/Navigation_page/Playlist_page.dart';
import 'package:projet/Navigation_page/Song_page.dart';
import 'package:projet/Navigation_page/search_page.dart';
import 'package:projet/musicPlayer.dart';

import '../app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String FolderPath = "";
  int _currentIndex = 0, _currentIndex2 = 0;

  final OnAudioQuery _audioQuery = OnAudioQuery();
  AudioPlayer mPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    requestPermission();
    _currentIndex = widget.index;
    setCurrentIndex(_currentIndex, _currentIndex, "");
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    setState(() {});
  }

  /*List pages = [
    const HomePage(),
    const SongsListPage(),
    const PlaylistPage(),
    const FavoriteListPage(),
    const FolderListPage(setHomeState: setCurrentIndex(index, path), ),
  ];*/

  void setCurrentIndex(int index1, int index2, String path ){
    setState(() {
      _currentIndex = index1;
      _currentIndex2 = index2;
      FolderPath = path;
      print("//////////////////$FolderPath////////////////");
    });
  }

  @override
  Widget build(BuildContext context) {
    //_currentIndex= widget.index;
    List pages = [
      HomePage(setHomeState: setCurrentIndex, player: mPlayer),
      SongsListPage(player: mPlayer),
      PlaylistPage(player: mPlayer),
      FavoriteListPage(player: mPlayer),
      FolderListPage(setHomeState: setCurrentIndex, player: mPlayer),
      FolderContain(path: FolderPath, player: mPlayer)
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed ,
        backgroundColor: firstColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.2),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: (currentIndex){
          setState(() {
            _currentIndex = currentIndex;
            _currentIndex2 = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,
                size: MediaQuery.of(context).size.width / 14),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_rounded,
                size: MediaQuery.of(context).size.width / 14),
            label: "Songs",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_rounded,
                  size: MediaQuery.of(context).size.width / 14),
              label: "Playlist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded,
                  size: MediaQuery.of(context).size.width / 14),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_rounded,
                  size: MediaQuery.of(context).size.width / 14),
              label: "Folders")
        ],
      ),
      backgroundColor: firstColor,
      body: pages[_currentIndex2],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: firstColor,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/img_2.png"),
              /*child: IconButton(
                onPressed: (){},
                splashRadius: 28.0,
                splashColor: secondColor,
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
              ),*/
            ),
          ),
          title: const Text(
            'MuXic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: IconButton(
                onPressed: toSearch,
                splashRadius: 28.0,
                splashColor: secondColor,
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
          ]
      ),
    );
  }

  void toSearch(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return SearchPage(player: mPlayer,);
    }));
  }
}
