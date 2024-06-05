import 'package:event/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_hole_demo_route_part.freezed.dart';

@freezed
class VideoHoleDemoRoutePart extends EventArgs with _$VideoHoleDemoRoutePart {
  factory VideoHoleDemoRoutePart.home() = _HomeVideoHoleDemoRoutePart;
  factory VideoHoleDemoRoutePart.player(String videoUrl) = _PlayerVideoHoleDemoRoutePart;
}
