import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget{
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState()=>_VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>{
  // cache manager
  FileInfo fileInfo;
  String url;
  String path;

  // video player
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  VideoPlayerController _video1;
  // VideoPlayerController _video2;



  _downloadFile(){
  url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  DefaultCacheManager().getFile(url).listen((f){
      setState(() {
        fileInfo = f;
      });
    });
  }

  @override
  void initState(){
    super.initState();
      _downloadFile();    
    _videoPlayerController1 = VideoPlayerController.network(url);
    _videoPlayerController2 = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3/2,
      autoPlay: true,
      looping: true,
        // Try playing around with some of these other options:

      showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose(){
    _video1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    if (fileInfo?.file != null){
      path = fileInfo.file.path;
      print('this is path $path');
      _video1 = VideoPlayerController.network(path);
    } else {
      _video1 = _videoPlayerController1;
    }
    // var from = "N/A";
    // if (fileInfo != null){
    //   from = fileInfo.source.toString();
    // }

    return MaterialApp(
      title:'Chewie Demo',
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chewi Demo'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            FlatButton(
              onPressed: (){
                _chewieController.enterFullScreen();
              },
              child: Text('Fullscreen'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController2.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _video1 ,
                          aspectRatio: 3/2,
                          autoPlay: true,
                          looping: true,
                          overlay: RichText(
                            text: TextSpan(
                              text: 'credential',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black.withOpacity(0.3),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        );
                      });
                    },
                    child: Padding(
                      child: Text("Video 1 cached"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                         _chewieController.dispose();
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController2,
                          aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          overlay: RichText(
                            text: TextSpan(
                              text: 'credential',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.black.withOpacity(0.3),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Video 2"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: Padding(
                      child: Text("Android controls"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}