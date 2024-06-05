import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_part.dart';

import 'inavigation_service.dart';

class NavigationService extends INavigationService {
  @override
  void navigateBack() {
    navigationBackEvent.broadcast();
  }

  @override
  void navigateTo(VideoHoleDemoRoutePart routePart) {
    navigationEvent.broadcast(routePart);
  }

  @override
  void navigateToRoot(VideoHoleDemoRoutePart routePart) {
    navigationToRootEvent.broadcast(routePart);
  }
}
