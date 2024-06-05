import 'package:flutter/material.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_part.dart';
import 'package:Video_hole_plus_player_demo/player/player_page.dart';

import '../home/home_page.dart';
import 'inavigation_service.dart';

class VideoHoleDemoRouteStack {
  final INavigationService navigationService;

  static const String _homeSegmentName = 'home';
  static const String _playerSegmentName = 'player';

  final navigationHistory = List<VideoHoleDemoRoutePart>.empty(growable: true);

  VideoHoleDemoRouteStack.defaultStack({
    required this.navigationService,
  }) {
    navigationHistory.add(VideoHoleDemoRoutePart.home());
  }

  VideoHoleDemoRouteStack.fromPathSegments(
      {required this.navigationService, required List<String> pathSegments}) {
    if (pathSegments.isEmpty) {
      navigationHistory.add(VideoHoleDemoRoutePart.home());
    } else {
      for (var segment in pathSegments) {
        switch (segment) {
          case _homeSegmentName:
            navigationHistory.add(VideoHoleDemoRoutePart.home());
            break;
          case _playerSegmentName:
            navigationHistory.add(VideoHoleDemoRoutePart.player(''));
            break;
          default:
            navigationHistory.add(VideoHoleDemoRoutePart.home());
            break;
        }
      }
    }
  }

  List<MaterialPage> toPages() {
    return navigationHistory
        .map<MaterialPage>((e) => e.map(
              home: (_) => MaterialPage(
                child: HomePage(
                  navigationService: navigationService,
                ),
              ),
              player: (playerRoutePart) => MaterialPage(
                  child: PlayerPage(
                videoUrl: playerRoutePart.videoUrl,
                navigationService: navigationService,
              )),
            ))
        .toList();
  }

  RouteInformation toRouteInformation() {
    final location = navigationHistory
        .map((e) => e.map(
              home: (_) => _homeSegmentName,
              player: (_) => _playerSegmentName,
            ))
        .join('/');

    return RouteInformation(location: location);
  }
}
