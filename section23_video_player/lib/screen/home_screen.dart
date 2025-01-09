import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: videoFile != null
          ? _VideoPlayer(
              video: videoFile!,
              onAnotherVideoPicked: onLogoTap,
            )
          : _VideoSelector(
              onLogoTap: onLogoTap,
            ),
    );
  }

  void onLogoTap() async {
    print("logo tapped");
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    setState(() {
      videoFile = video;
    });
    print(video);
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Video",
          style: textStyle,
        ),
        Text(
          "Player",
          style: textStyle.copyWith(
            // copyWith() 메서드를 사용하여 기존의 스타일을 복사하고 변경할 수 있다.
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onAnotherVideoPicked;

  const _VideoPlayer({
    super.key,
    required this.video,
    required this.onAnotherVideoPicked,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool showIcons = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializerController();
  }

  @override
  didUpdateWidget(covariant _VideoPlayer oldWidget) {
    // didUpdateWidget() 메서드는 위젯이 업데이트 될 때 호출된다.
    super.didUpdateWidget(oldWidget);

    /// 이전 위젯의 비디오 경로와 현재 위젯의 비디오 경로가 다르면 비디오 플레이어를 초기화한다.
    if (oldWidget.video.path != widget.video.path) {
      videoPlayerController.dispose();
      initializerController();
    }
  }

  initializerController() async {
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );

    await videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      setState(() {});
    }); // 비디오가 재생되는 동안 계속해서 호출되는 메서드
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showIcons = !showIcons;
        });
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            // Stack 위젯은 자식 위젯을 겹쳐서 배치할 수 있는 위젯이다. (넣은 순서대로 뒤에 배치됨)
            children: [
              VideoPlayer(
                videoPlayerController,
              ),
              if(showIcons) Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
              if (showIcons)
                _PlayButtons(
                  onReversePressed: onReversePressed,
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  videoPlayerController: videoPlayerController,
                ),
              if (showIcons)
                _BottomSlider(
                  videoPlayerController: videoPlayerController,
                  onSliderChanged: onSliderChanged,
                ),
              if (showIcons)
                _PickAnotherVideo(
                  onTap: widget.onAnotherVideoPicked,
                ),

            ],
          ),
        ),
      ),
    );
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController.value.position;

    /// 비디오의 현재 위치에서 3초를 뺀 위치로 이동.
    /// 3초를 뺀 위치가 0보다 작으면 0으로 설정
    Duration position = Duration();

    if (currentPosition.inMilliseconds > 3000) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  void onPlayPressed() {
    setState(() {
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
      } else {
        videoPlayerController.play();
      }
    });
  }

  void onForwardPressed() {
    final maxPosition = videoPlayerController.value.duration;
    final currentPosition = videoPlayerController.value.position;

    /// 비디오의 현재 위치에서 3초를 더한 위치로 이동.
    Duration position = maxPosition;

    if ((maxPosition - Duration(seconds: 3)) > currentPosition) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  void onSliderChanged(double value) {
    final position = Duration(milliseconds: value.toInt());
    videoPlayerController.seekTo(position);
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;

  const _VideoSelector({
    super.key,
    required this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.8],
          colors: [
            Color(0xff2a3a7c),
            Color(0xff000118),
          ],
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          SizedBox(
            height: 20,
          ),
          _Title(),
        ],
      ),
    );
  }
}

class _PlayButtons extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final VideoPlayerController videoPlayerController;

  const _PlayButtons({
    super.key,
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.videoPlayerController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: onReversePressed,
            icon: Icon(Icons.rotate_left),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onPlayPressed,
            icon: videoPlayerController.value.isPlaying
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onForwardPressed,
            icon: Icon(Icons.rotate_right),
          ),
        ],
      ),
    );
  }
}

class _BottomSlider extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  final ValueChanged<double> onSliderChanged;

  const _BottomSlider({
    super.key,
    required this.videoPlayerController,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              "${videoPlayerController.value.position.inMinutes}:${(videoPlayerController.value.position.inSeconds % 60).toString().padLeft(2, '0')}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: videoPlayerController.value.position.inMilliseconds
                    .toDouble(),
                max: videoPlayerController.value.duration.inMilliseconds
                    .toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              "${videoPlayerController.value.duration.inMinutes}:${(videoPlayerController.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickAnotherVideo extends StatelessWidget {
  final VoidCallback onTap;

  const _PickAnotherVideo({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        color: Colors.white,
        onPressed: onTap,
        icon: Icon(Icons.photo_camera_back),
      ),
    );
  }
}
