import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:Video_hole_plus_player_demo/navigation/inavigation_service.dart';
import 'package:video_player_avplay/video_player.dart';

class PlayerPage extends StatefulWidget {
  final String videoUrl;
  final INavigationService navigationService;

  const PlayerPage(
      {super.key, required this.videoUrl, required this.navigationService});

  @override
  State<StatefulWidget> createState() => PlayerPageState();
}

class PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _controller;
  Completer<void> assetLoadingCompleter = Completer<void>();
  int times = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'http://wp1-vxtoken-obc0304-hzn-ci.t1.lab.dyncdn.dmdsdp.com/dash/GO-AVC-DASH/NPO2_HD_CI/manifest.mpd',
      drmConfigs: DrmConfigs(
        type: DrmType.playready,
        licenseCallback: (Uint8List challenge) async {
          final http.Response response = await http.post(
            Uri.parse('https://lgilab5aitc.test.ott.irdeto.com/licenseServer/playready/v1/lgilab5aitc/license?contentId=LV-nPRM-GRP2'),
            body: challenge,
          );
          return response.bodyBytes;
        },
      ),
    );

    _controller.addListener(() {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
      }
      setState(() {});
    });
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        times++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            _timer.cancel();
            _controller.dispose().then((value) => Navigator.of(context).pop());
          }

          return KeyEventResult.handled;
        },
        child: Stack(children: [
          VideoPlayer(
            _controller,
          ),
          FutureBuilder(
              future: assetLoadingCompleter.future,
              builder: (context, snaphot) {
                return Center(
                    child: snaphot.connectionState == ConnectionState.done
                        ? const SizedBox()
                        : const CircularProgressIndicator());
              }),
          Text(
            'Its a sample text over the player frame Times: $times',
            style: const TextStyle(fontSize: 48),
          )
        ]));
  }
}
