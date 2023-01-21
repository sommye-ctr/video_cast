part of video_cast;

final ChromeCastPlatform _chromeCastPlatform = ChromeCastPlatform.instance;

/// Controller for a single ChromeCastButton instance running on the host platform.
class ChromeCastController {
  /// The id for this controller
  final int id;

  Timer? _timer;
  StreamController<Duration>? _streamController;

  ChromeCastController._({required this.id});

  /// Initialize control of a [ChromeCastButton] with [id].
  static Future<ChromeCastController> init(int id) async {
    await _chromeCastPlatform.init(id);
    return ChromeCastController._(id: id);
  }

  /// Add listener for receive callbacks.
  Future<void> addSessionListener() {
    return _chromeCastPlatform.addSessionListener(id: id);
  }

  /// Remove listener for receive callbacks.
  Future<void> removeSessionListener() {
    return _chromeCastPlatform.removeSessionListener(id: id);
  }

  /// Load a new media <br>
  /// [url] - Url of the media <br>
  /// [type] - Type of media <br>
  /// [title] - Title of the media <br>
  /// [description] - Description of the media<br>
  /// [image] - Image url of the media<br>
  /// [position] - Position (in ms) from which to start the media<br>
  /// [autoplay] - Flag to disable/enable autoplay<br>
  /// [showSeason] - Season No. for tv show<br>
  /// [showEpisode] - Episode No. for tv show<br>
  /// [subtitles] - Subtitle tracks
  Future<void> loadMedia({
    required ChromeCastMediaType type,
    required String url,
    required String title,
    List<ChromeCastSubtitle>? subtitles,
    String? description,
    String? image,
    double position = 0,
    bool autoplay = true,
    int? showSeason,
    int? showEpisode,
  }) {
    return _chromeCastPlatform.loadMedia(
      id: id,
      url: url,
      position: position,
      autoplay: autoplay,
      title: title,
      description: description ?? "",
      image: image ?? "",
      type: type,
      showEpisode: showEpisode,
      showSeason: showSeason,
      subtitles: subtitles,
    );
  }

  /// Plays the video playback.
  Future<void> play() {
    return _chromeCastPlatform.play(id: id);
  }

  /// Pauses the video playback.
  Future<void> pause() {
    return _chromeCastPlatform.pause(id: id);
  }

  /// If [relative] is set to false sets the video position to an [interval] from the start.
  ///
  /// If [relative] is set to true sets the video position to an [interval] from the current position.
  Future<void> seek({bool relative = false, double interval = 10.0}) {
    return _chromeCastPlatform.seek(relative, interval, id: id);
  }

  /// Set volume 0-1
  Future<void> setVolume({double volume = 0}) {
    return _chromeCastPlatform.setVolume(volume, id: id);
  }

  /// Set active subtitle track
  /// [subId] - Subtitle unique id passed in loadMedia()
  Future<void> setTrack({required double subId}) {
    return _chromeCastPlatform.updateTracks(id: id, subId: subId);
  }

  /// Disables the current active subtitle track
  Future<void> disableTrack() {
    return _chromeCastPlatform.disableTracks(id: id);
  }

  /// Get current volume
  Future<double> getVolume() {
    return _chromeCastPlatform.getVolume(id: id);
  }

  /// Stop the current video.
  Future<void> stop() {
    return _chromeCastPlatform.stop(id: id);
  }

  /// Returns `true` when a cast session is connected, `false` otherwise.
  Future<bool?> isConnected() {
    return _chromeCastPlatform.isConnected(id: id);
  }

  /// End current session
  Future<void> endSession() {
    return _chromeCastPlatform.endSession(id: id);
  }

  /// Returns `true` when a cast session is playing, `false` otherwise.
  Future<bool?> isPlaying() {
    return _chromeCastPlatform.isPlaying(id: id);
  }

  /// Returns current position.
  Future<Duration> position() {
    return _chromeCastPlatform.position(id: id);
  }

  /// Returns video duration.
  Future<Duration> duration() {
    return _chromeCastPlatform.duration(id: id);
  }

  /// Returns a stream for progress updates.
  /// Call cancelTimer() to dispose
  Stream<Duration> onProgressEvent() {
    _streamController = StreamController<Duration>();

    _timer = Timer.periodic(
      const Duration(
        milliseconds: 500,
      ),
      (timer) async {
        Duration duration = await position();
        _streamController?.add(duration);
      },
    );

    return _streamController!.stream;
  }

  /// Cancels timer of progress updates.
  void cancelTimer() {
    _timer?.cancel();
    _streamController?.close();
  }
}
