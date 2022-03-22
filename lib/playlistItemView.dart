import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet/app_data.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);


  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 12.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),
      color: secondColor,
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 2.0 : MediaQuery.of(context).size.width / 3.0,
          height: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 1.8 : MediaQuery.of(context).size.width / 2.7,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Column(
            children:[
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: AspectRatio(
                    aspectRatio: 1.25,
                    child: Image(
                      image: AssetImage("assets/Girl.webp"),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Titre playlist",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Nombre de chanson",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.play_arrow, color: Colors.white, size: 30.0,),
                        )
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
