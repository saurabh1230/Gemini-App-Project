import 'package:flutter/material.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchLearnComponent extends StatefulWidget {
  final String title;
  final String videoUrl;
  final Function() saveNote;
  final Color saveNoteColor;

  const WatchLearnComponent({
    super.key,
    required this.title,
    required this.videoUrl,
    required this.saveNote,
    required this.saveNoteColor,
  });

  @override
  _WatchLearnComponentState createState() => _WatchLearnComponentState();
}

class _WatchLearnComponentState extends State<WatchLearnComponent> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _youtubeController.addListener(() {
      if (_youtubeController.value.isPlaying) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _playVideo() {
    _youtubeController.play();
  }

  void _pauseVideo() {
    _youtubeController.pause();
  }

  void _stopVideo() {
    _youtubeController.pause();
    _youtubeController.seekTo(Duration.zero);
  }


  void _launchYouTube() async {
    final String url = widget.videoUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  void _seekToPosition(double value) {
    final position = Duration(milliseconds: (value * 1000).toInt());
    _youtubeController.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    final duration = _youtubeController.metadata.duration.inSeconds.toDouble() ?? 0.0;
    final position = _youtubeController.value.position.inSeconds.toDouble();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Title and Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.saveNote,
                  child: Container(
                    height: 50.0,
                    clipBehavior: Clip.hardEdge,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.bookmark,
                        color: widget.saveNoteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            sizedBox20(),
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: false,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {

              },
            ),

            Slider(
              value: position,
              min: 0.0,
              max: duration,
              onChanged: (value) {
                _seekToPosition(value);
              },
            ),
            sizedBox10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _youtubeController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    _youtubeController.value.isPlaying
                        ? _pauseVideo()
                        : _playVideo();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: _stopVideo,
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: _launchYouTube,
                ),
              ],
            ),
            sizedBox20(),
          ],
        ),
      ),
    );
  }
}
