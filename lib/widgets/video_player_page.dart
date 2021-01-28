import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

class VideoPlayerTestWidget extends StatefulWidget {
  @override
  _VideoPlayerTestWidgetState createState() => _VideoPlayerTestWidgetState();
}

class _VideoPlayerTestWidgetState extends State<VideoPlayerTestWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4")
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller))
              : Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

// class VoicePlayerWidget extends StatefulWidget {
//   @override
//   _VoicePlayerWidgetState createState() => _VoicePlayerWidgetState();
// }

// class _VoicePlayerWidgetState extends State<VoicePlayerWidget> {
//   AudioPlayer audioPlayer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     audioPlayer = AudioPlayer();
//   }

//   play() async {
//     int reuslt = await audioPlayer.play(
//         "https://gm-sycdn.kuwo.cn/81a47e681c4b003194536f2260b9a51e/600170cb/resource/n2/73/81/1062648582.mp3");
//     if (reuslt == 1) {
//       print('play success');
//     } else {
//       print('play failed');
//     }
//   }

//   pause() async {
//     int result = await audioPlayer.pause();
//     if (result == 1) {
//       // success
//       print('pause success');
//     } else {
//       print('pause failed');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           play();
//         },
//       ),
//     );
//   }
// }
