import 'package:event/event.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_part.dart';

abstract class INavigationService {
  Event<VideoHoleDemoRoutePart> navigationEvent, navigationToRootEvent;
  Event navigationBackEvent;
  void navigateTo(VideoHoleDemoRoutePart routePart);
  void navigateToRoot(VideoHoleDemoRoutePart routePart);
  void navigateBack();

  INavigationService()
      : navigationEvent = Event<VideoHoleDemoRoutePart>(),
        navigationToRootEvent = Event<VideoHoleDemoRoutePart>(),
        navigationBackEvent = Event();
}
