import 'package:flutter/material.dart';
import 'package:video_cast/chrome_cast_media_type.dart';
import 'package:video_cast/chrome_cast_subtitle.dart';
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
          child: Column(
            children: [
              const Text("ChromeCastButton"),
              const SizedBox(
                height: 5,
              ),
              ChromeCastButton(
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
                  castController?.onProgressEvent().listen((event) {
                    print("in app progress ${event.inMilliseconds}");
                  });
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
                    subtitles: [
                      ChromeCastSubtitle(
                        id: 1,
                        language: "en-US",
                        name: "English",
                        source:
                            "https://cc.2cdns.com/3e/62/3e62d0109500abf55acf229a0599a20d/3e62d0109500abf55acf229a0599a20d.vtt",
                      ),
                      ChromeCastSubtitle(
                        id: 2,
                        language: "ar",
                        name: "Arabic",
                        source:
                            "https://cc.2cdns.com/91/bd/91bdc91ffff0906bd54f0711eb3e786f/91bdc91ffff0906bd54f0711eb3e786f.vtt",
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  castController?.setTrack(subId: 1);
                },
                child: const Text("Set Track 1"),
              ),
              ElevatedButton(
                onPressed: () {
                  castController?.setTrack(subId: 2);
                },
                child: const Text("Set Track 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  castController?.disableTrack();
                },
                child: const Text("Disable Track"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    castController?.cancelTimer();
    super.dispose();
  }
}
