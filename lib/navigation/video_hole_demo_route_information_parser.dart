import 'package:flutter/material.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_stack.dart';

import 'inavigation_service.dart';

class VideoHoleDemoRouteInformationParser
    extends RouteInformationParser<VideoHoleDemoRouteStack> {
  final INavigationService navigationService;

  VideoHoleDemoRouteInformationParser({
    required this.navigationService,
  });

  @override
  Future<VideoHoleDemoRouteStack> parseRouteInformation(
      RouteInformation routeInformation) {
    var uri = routeInformation.uri;

    return Future.value(VideoHoleDemoRouteStack.fromPathSegments(
      navigationService: navigationService,
      pathSegments: uri.pathSegments,
    ));
  }

  @override
  RouteInformation? restoreRouteInformation(
      VideoHoleDemoRouteStack configuration) {
    return configuration.toRouteInformation();
  }
}
