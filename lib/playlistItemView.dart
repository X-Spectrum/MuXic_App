import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet/app_data.dart';

class PlaylistItem extends StatefulWidget {
  const PlaylistItem({Key? key}) : super(key: key);


  @override
  State<PlaylistItem> createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.only(left: 12.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),
      color: secondColor,
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 2.5 : MediaQuery.of(context).size.width / 3.0,
          height: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 2.3 : MediaQuery.of(context).size.width / 2.7,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Column(
            children:[
              Container(
                margin: EdgeInsets.only(top: 0),
                width: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 2.5 : MediaQuery.of(context).size.width / 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.playlist_play_rounded,
                  size: (MediaQuery.of(context).orientation == Orientation.portrait) ? MediaQuery.of(context).size.width / 3.5 : MediaQuery.of(context).size.width / 3.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
                      color: Colors.white30,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 7.0),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              "000",
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
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
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
