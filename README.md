# video_cast

Flutter plugin for casting videos on chromecast devices

## Installation

First, add `video_cast` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### Android

Add dependencies in your module (app-level) Gradle file (usually `android/app/build.gradle`):

```groovy
implementation 'com.google.android.gms:play-services-cast-framework:21.2.0'
implementation 'com.google.android.exoplayer:extension-cast:2.17.1'
```

Set the theme of the MainActivity to `@style/Theme.AppCompat.NoActionBar` in the application manifest `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.gms.cast.framework.OPTIONS_PROVIDER_CLASS_NAME"
               android:value="com.google.android.exoplayer2.ext.cast.DefaultCastOptionsProvider"/>
    ...
    <activity android:theme="@style/Theme.AppCompat.NoActionBar" ...
```

Make `MainActivity` extends `FlutterFragmentActivity` and initialize the Cast context:

```kotlin
CastContext.getSharedInstance(applicationContext)
```

### Using ChromeCaastButton

You can now add a `ChromeCastButton` widget to your widget tree.

The button can be controlled with the `ChromeCastController` that is passed to
the `ChromeCastButton`'s `onButtonCreated` callback.

```dart
import 'package:flutter/material.dart';
import 'package:video_cast/video_cast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CastSample(),
    );
  }
}


class CastSample extends StatefulWidget {
  @override
  _CastSampleState createState() => _CastSampleState();
}

class _CastSampleState extends State<CastSample> {
  ChromeCastController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cast Sample'),
        actions: [
          ChromeCastButton(
            onButtonCreated: (controller) {
              setState(() => _controller = controller);
              _controller?.addSessionListener();
            },
            onSessionStarted: () {
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
        ],
      ),
    );
  }
}
```

See the `example` directory for a complete sample app.
