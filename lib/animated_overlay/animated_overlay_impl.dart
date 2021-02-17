import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_widget.dart';

class AnimatedOverlay implements IOverlay {
  final double height;
  final FocusNode focusNode;
  final Widget dropdownContent;
  final VoidCallback closeOverlay;
  final Duration animationDuration;

  @override
  final String id;

  AnimatedOverlay({
    @required this.id,
    this.height,
    this.focusNode,
    this.closeOverlay,
    this.dropdownContent,
    this.animationDuration,
  });

  @override
  Widget get widget {
    return AnimatedOverlayWidget(
      height: height,
      focusNode: focusNode,
      closeOverlay: closeOverlay,
      dropdownContent: dropdownContent,
      animationDuration: animationDuration,
    );
  }
}
