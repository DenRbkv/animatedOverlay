import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_widget.dart';

class AnimatedOverlay implements IOverlay {
  final FocusNode focusNode;
  final Widget dropdownContent;
  final VoidCallback closeOverlay;

  @override
  final String id;

  AnimatedOverlay({
    @required this.id,
    this.focusNode,
    this.closeOverlay,
    this.dropdownContent,
  });

  @override
  Widget get widget => AnimatedOverlayWidget(
        focusNode: focusNode,
        closeOverlay: closeOverlay,
        dropdownContent: dropdownContent,
      );
}
