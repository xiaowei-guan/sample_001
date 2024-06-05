import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Focusable extends StatefulWidget {
  final Widget Function(bool) builder;
  final void Function() onClicked;

  Focusable(this.builder, this.onClicked);

  @override
  State<StatefulWidget> createState() => FocusableState();
}

class FocusableState extends State<Focusable> {
  bool _isFocused = false;

  final navigationMap = {
    LogicalKeyboardKey.arrowRight: TraversalDirection.right,
    LogicalKeyboardKey.arrowLeft: TraversalDirection.left,
    LogicalKeyboardKey.arrowUp: TraversalDirection.up,
    LogicalKeyboardKey.arrowDown: TraversalDirection.down,
  };

  @override
  Widget build(BuildContext context) {
    return Focus(
        onKeyEvent: (node, event) {
          if (event is! KeyDownEvent) {
            return KeyEventResult.ignored;
          }

          if (navigationMap.containsKey(event.logicalKey)) {
            FocusManager.instance.primaryFocus?.focusInDirection(navigationMap[event.logicalKey]!);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.enter) {
            widget.onClicked();
          }

          return KeyEventResult.ignored;
        },
        autofocus: true,
        onFocusChange: (isFocused) => setState(() {
              _isFocused = isFocused;
            }),
        child: widget.builder(_isFocused));
  }
}
