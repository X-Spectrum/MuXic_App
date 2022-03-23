import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:projet/Navigation_page/Folder_contain.dart';
import 'package:projet/Navigation_page/Home_screen.dart';
import 'package:projet/app_data.dart';
import 'package:projet/musicItemView.dart';

class FolderListPage extends StatefulWidget {
  FolderListPage({Key? key, required this.setHomeState}) : super(key: key);
  Function setHomeState;
  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<String> paths = [];
  final GlobalKey<HomeScreenState> cle = GlobalKey<HomeScreenState>();

  void toFolderContain(String path){

    /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return HomeScreen(key: cle);
    }));*/
  }

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
                "Dossiers",
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
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: FutureBuilder<List<SongInfo>>(
                    future: audioQuery.getSongs(),
                    builder: (context, item){
                      if(item.data == null){
                        return const Center(child: CircularProgressIndicator());
                      }
                      if(item.data!.isNotEmpty){
                        String path = "";
                        for(int i=0; i < item.data!.length; i++){

                          path = item.data![i].filePath.split(item.data![i].displayName).first;
                          path = path.replaceFirst("/", "", path.length-1);

                          if(!paths.contains(path)){
                            paths.add(path);
                          }
                        }
                        return ListView.builder(
                          itemCount: paths.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ListTile(
                              leading: Container(
                                  width: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
                                  height: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 7.0 : MediaQuery.of(context).size.width / 12.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: secondColor,
                                  ),
                                  child: const Icon(
                                    Icons.folder_rounded,
                                    color: Colors.grey,
                                    size: 30,)
                              ),
                              title: Text(paths[index].split("/").last, overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                              subtitle: Text(paths[index], overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              onTap: () => widget.setHomeState(4, 5, paths[index]),
                            ),
                          ),
                        );
                      }
                      return const Text(
                        "Aucune chanson trouvée",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}