import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = "702aca58b91a4d45b9271b349bb0f428";
const String channelName = "handsApp";
const String token =
    '007eJxTYOC6fWlfpIeO/ZHXF3n0Ujnvl2gVp2wSO6izdtpN572mebMUGMwNjBKTE00tkiwNE01STEyTLI3MDZOMTSyTkgzSTIwsNM5KZzQEMjLMl7rMwAiFID4HQ0ZiXkqxY0EBAwMAhKAftw==';

late final RtcEngine agoraEngine;

Future<void> initializeAgora() async {
  await [Permission.microphone, Permission.camera].request();

  agoraEngine = createAgoraRtcEngine();
  await agoraEngine.initialize(const RtcEngineContext(appId: appId));

  await agoraEngine.enableVideo();
  await agoraEngine.startPreview();

  await agoraEngine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
    dimensions: const VideoDimensions(width: 640, height: 360),
    frameRate: 15,
    bitrate: 800,
    orientationMode: OrientationMode.orientationModeAdaptive,
  ));

  await agoraEngine.joinChannel(
    token: token,
    channelId: channelName,
    uid: 0,
    options: const ChannelMediaOptions(),
  );
}
