import 'package:flutter/material.dart';
import 'package:Video_hole_plus_player_demo/navigation/inavigation_service.dart';
import 'package:Video_hole_plus_player_demo/navigation/video_hole_demo_route_part.dart';

import 'focusable.dart';
import 'grid_tile.dart';

class HomePage extends StatelessWidget {
  final tileModels = [
    _TileModel(
        'https://static1.colliderimages.com/wordpress/wp-content/uploads/2022/07/Why-The-Orville-Isnt-Just-a-Star-Trek-Ripoff-feature.jpg',
        'The key, scrollDirection, reverse, controller, primary, physics, and shrinkWrap properties on GridView map directly to the identically named properties on CustomScrollView.',
        'https://cdn.bitmovin.com/content/assets/art-of-motion-dash-hls-progressive/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'),
    _TileModel(
        'https://static1.colliderimages.com/wordpress/wp-content/uploads/2022/07/Why-The-Orville-Isnt-Just-a-Star-Trek-Ripoff-feature.jpg',
        'Sintel.',
        'https://storage.googleapis.com/shaka-demo-assets/sintel-mp4-only/dash.mpd'),
  ];

  final INavigationService navigationService;

  HomePage({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6),
            cacheExtent: 5000,
            itemCount: 2000,
            itemBuilder: (context, index) {
              final model = getTileModel(index);
              return Focusable(
                  (isFocused) =>
                      TestGridTile(model.imageUrl, model.title, isFocused), () {
                navigationService
                    .navigateTo(VideoHoleDemoRoutePart.player(model.videoUrl));
              });
            }));
  }

  _TileModel getTileModel(int index) {
    return tileModels[index % tileModels.length];
  }
}

class _TileModel {
  String imageUrl;
  String title;
  String videoUrl;

  _TileModel(this.imageUrl, this.title, this.videoUrl);
}
