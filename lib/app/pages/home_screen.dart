import 'package:flutter/material.dart';
import 'package:my_flutter/app/pages/video_player/video_player_view.dart';
import 'package:my_flutter/app/pages/pdf_viewer/pdf_view.dart';

class HomeScreen extends StatefulWidget {
  @override 
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Feature Demo'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding:  const EdgeInsets.all(8.0),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>VideoPlayerScreen(),
                ));
              },
              child: new Text("Video Player Demo"),
            ),
            RaisedButton(
              // padding:  const EdgeInsets.all(8.0),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>PdfViewScreen(),
                ));
              },
              child: new Text("Pdf Doc Demo"),
            ),
          ],
        ),
      ),
    );
  }
}