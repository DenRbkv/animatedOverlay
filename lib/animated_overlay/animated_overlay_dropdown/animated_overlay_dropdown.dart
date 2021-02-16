import 'dart:math';

import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_impl.dart';

class AnimatedOverlayDropdown extends StatefulWidget {
  final String uniqueId;
  final FocusNode focusNode;
  final Widget dropdownHeader;
  final Widget dropdownContent;

  const AnimatedOverlayDropdown({
    @required this.uniqueId,
    this.focusNode,
    this.dropdownHeader,
    this.dropdownContent,
    Key key,
  }) : super(key: key);

  @override
  _AnimatedOverlayDropdownState createState() => _AnimatedOverlayDropdownState();
}

class _AnimatedOverlayDropdownState extends State<AnimatedOverlayDropdown> {
  String _uniqueId;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _uniqueId = widget.uniqueId ?? Random().nextInt(99999).toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isOverlayCreated = OverlayManager.instance.isOverlayCreated;

        if (isOverlayCreated) {
          _focusNode.unfocus();
        }

        if (!isOverlayCreated) {
          OverlayManager.instance.show(_uniqueId);
          _focusNode.requestFocus();
        }
      },
      child: OverlayManager.instance.buildOverlay(
        focusNode: _focusNode,
        overlay: AnimatedOverlay(
          id: _uniqueId,
          focusNode: _focusNode,
          closeOverlay: OverlayManager.instance.close,
          dropdownContent: widget.dropdownContent,
        ),
        child: widget.dropdownHeader ?? const SizedBox(),
      ),
    );
  }
}
