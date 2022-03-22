import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet/Navigation_page/Favorite_page.dart';
import 'package:projet/Navigation_page/Folder_page.dart';
import 'package:projet/Navigation_page/Home_page.dart';
import 'package:projet/Navigation_page/Playlist_page.dart';
import 'package:projet/Navigation_page/Song_page.dart';
import 'package:projet/Navigation_page/search_page.dart';

import '../app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, /*required this.index*/}) : super(key: key);
  //final int index;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  /*Function setCurrentIndex(int newIndex){
    _currentIndex = newIndex;
  }*/
  List pages = [
    const HomePage(),
    const SongsListPage(),
    const PlaylistPage(),
    const FavoriteListPage(),
    const FolderListPage(),
  ];

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      HomePage(moveToPage: setCurrentIndex(index)),
      const SongsListPage(),
      const PlaylistPage(),
      const FavoriteListPage(),
      const FolderListPage(),
    ]
  }*/
  @override
  Widget build(BuildContext context) {
    Widget currentWidget = pages[_currentIndex];
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
      body: currentWidget,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: firstColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: (){},
              splashRadius: 28.0,
              splashColor: secondColor,
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
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
      return SearchPage();
    }));
  }
}
