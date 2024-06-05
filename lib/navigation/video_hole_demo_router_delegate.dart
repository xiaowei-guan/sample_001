import 'package:flutter/material.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_stack.dart';

import 'inavigation_service.dart';

class VideoHoleDemoRouterDelegate
    extends RouterDelegate<VideoHoleDemoRouteStack> with ChangeNotifier {
  final INavigationService navigationService;

  VideoHoleDemoRouteStack? _currentConfiguration;

  @override
  VideoHoleDemoRouteStack get currentConfiguration =>
      _currentConfiguration ??
      VideoHoleDemoRouteStack.defaultStack(
        navigationService: navigationService,
      );

  VideoHoleDemoRouterDelegate({
    required this.navigationService,
  }) {
    _currentConfiguration = VideoHoleDemoRouteStack.defaultStack(
      navigationService: navigationService,
    );
    navigationService.navigationEvent.subscribe((args) {
      if (args == null) return;
      currentConfiguration.navigationHistory.add(args);
      notifyListeners();
    });

    navigationService.navigationToRootEvent.subscribe((args) {
      if (args == null) return;
      currentConfiguration.navigationHistory.clear();
      currentConfiguration.navigationHistory.add(args);
      notifyListeners();
    });

    navigationService.navigationBackEvent.subscribe((args) {
      currentConfiguration.navigationHistory.clear();
      //currentConfiguration.navigationHistory.removeLast();
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: currentConfiguration.toPages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        currentConfiguration.navigationHistory.removeLast();
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(VideoHoleDemoRouteStack configuration) {
    _currentConfiguration = configuration;
    notifyListeners();

    return Future.value();
  }
}
