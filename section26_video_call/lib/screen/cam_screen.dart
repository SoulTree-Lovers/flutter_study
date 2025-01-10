import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:section26_video_call/const/keys.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int uid = 0;
  int? remoteUid;

  Future<void> init() async {
    final response = await [
      // 권한 요청 후 응답 저장
      Permission.camera,
      Permission.microphone,
    ].request();

    final cameraPermission = response[Permission.camera];
    final microphonePermission = response[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw Exception('카메라 혹은 마이크 권한이 없습니다.');
    }

    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: appId,
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (
            RtcConnection connection,
            int elapsed,
          ) {
            print('--- Join Channel ---');
          },
          onLeaveChannel: (
            RtcConnection connection,
            RtcStats stats,
          ) {
            print('--- Leave Channel ---');
          },
          onUserJoined: (
            RtcConnection connection,
            int remoteUid,
            int elapsed,
          ) {
            print("--- User Joined! ---");
            setState(() {
              this.remoteUid = remoteUid;
            });
          },
          onUserOffline: (
            RtcConnection connection,
            int remoteUid,
            UserOfflineReasonType reason,
          ) {
            print("--- User Offline! ---");
            setState(() {
              this.remoteUid = null;
            });
          },


        )
      );

      await engine!.enableVideo();
      await engine!.startPreview();

      ChannelMediaOptions option = ChannelMediaOptions();

      await engine!.joinChannel(
        token: token,
        channelId: channelName,
        uid: uid,
        options: option,
      );

      print("Join Channel");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CamScreen'),
      ),
      body: FutureBuilder<void>(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            return Stack(
              children: [
                Container(
                  child: renderMainView(),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine!,
                      canvas: VideoCanvas(
                        uid: uid,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      engine!.leaveChannel();
                      engine!.release();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "나가기",
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (remoteUid == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine!,
        canvas: VideoCanvas(
          uid: remoteUid,
        ),
        connection: RtcConnection(
          channelId: channelName,
        ),
      ),
    );
  }
}
