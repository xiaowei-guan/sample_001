import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_router_delegate.dart';

import 'navigation/inavigation_service.dart';
import 'navigation/navigation_service.dart';
import 'navigation/video_hole_demo_route_information_parser.dart';

void main() {
  var container = GetIt.asNewInstance();
  setupDependencies(container);

  runApp(MaterialApp.router(
    routeInformationParser:
        container.get<VideoHoleDemoRouteInformationParser>(),
    routerDelegate: container.get<VideoHoleDemoRouterDelegate>(),
  ));
}

void setupDependencies(GetIt container) {
  container.registerSingleton<INavigationService>(NavigationService());
  container.registerSingleton(VideoHoleDemoRouteInformationParser(
    navigationService: container.get(),
  ));
  container.registerSingleton(VideoHoleDemoRouterDelegate(
    navigationService: container.get(),
  ));
}
