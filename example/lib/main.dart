import 'package:flutter/material.dart';
import 'package:video_cast/chrome_cast_media_type.dart';
import 'package:video_cast/video_cast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ChromeCastController? castController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ChromeCastButton(
            color: Colors.red,
            onButtonCreated: (controller) {
              castController = controller;
              castController?.addSessionListener();
            },
            onSessionEnding: (position) {
              print("in app ending");
              print("position is $position");
            },
            onSessionEnded: () {
              print("in app ended");
            },
            onSessionStarted: () {
              print("in app started");
              castController?.loadMedia(
                url:
                    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                position: 30000,
                autoplay: true,
                title: "Spider-Man: No Way Home",
                description:
                    "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
                image:
                    "https://terrigen-cdn-dev.marvel.com/content/prod/1x/marvsmposterbk_intdesign.jpg",
                type: ChromeCastMediaType.movie,
              );
            },
          ),
        ),
      ),
    );
  }
}
