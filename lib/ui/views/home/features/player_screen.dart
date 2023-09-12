import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:housematic_radio/const/app_colors.dart';

class PlayerScreen extends StatefulWidget {
  Map data;
  PlayerScreen({required this.data});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // For Audio
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  double volume = 0.5;

  String? time(Duration duration) {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    final hours = twodigits(duration.inHours);
    final minutes = twodigits(duration.inMinutes.remainder(60));
    final seconds = twodigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  Future setAudio(data) async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.setSourceUrl(data);
  }

  configureAudio() {
    print(widget.data['source']);
    setAudio(widget.data['source']);
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (this.mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (this.mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (this.mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  @override
  void initState() {
    configureAudio();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 20,
        ),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.data['thumbnail'],
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noThumb,
              ),
              child: Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                    await audioPlayer.resume();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time(position) ?? ''),
                  Text(time(duration) ?? ''),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  duration == Duration.zero
                      ? SizedBox()
                      : FloatingActionButton.small(
                          backgroundColor: AppColors.green,
                          heroTag: '0',
                          onPressed: () {
                            if (volume < 1.0) {
                              volume += 0.1;
                              print(volume);
                            }
                            audioPlayer.setVolume(volume);
                          },
                          child: Icon(Icons.add_circle_outline),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: duration == Duration.zero
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer.resume();
                              }
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            iconSize: 30,
                          ),
                  ),
                  duration == Duration.zero
                      ? SizedBox()
                      : FloatingActionButton.small(
                          backgroundColor: AppColors.green,
                          heroTag: '1',
                          onPressed: () {
                            if (volume > 0.0) {
                              volume -= 0.1;
                              print(volume);
                            }
                            audioPlayer.setVolume(volume);
                          },
                          child: Icon(Icons.do_not_disturb_on_outlined),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
