import 'dart:math';

import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_container.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_impl.dart';

class AnimatedOverlayDropdown extends StatefulWidget {
  final String uniqueId;
  final FocusNode focusNode;
  final double contentHeight;
  final Widget dropdownHeader;
  final Widget dropdownContent;
  final Duration animationDuration;

  const AnimatedOverlayDropdown({
    @required this.uniqueId,
    this.focusNode,
    this.contentHeight = 100.0,
    this.dropdownHeader = const SizedBox(),
    this.dropdownContent = const SizedBox(),
    this.animationDuration = const Duration(milliseconds: 300),
    Key key,
  }) : super(key: key);

  @override
  _AnimatedOverlayDropdownState createState() => _AnimatedOverlayDropdownState();
}

class _AnimatedOverlayDropdownState extends State<AnimatedOverlayDropdown> {
  static const tag = '[Animated Overlay Dropdown]';

  String _uniqueId;
  FocusNode _focusNode;
  Duration _switchDelay;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      print('$tag => <initState> => External FocusNode not found. Using internal FocusNode');
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode;
    }

    _uniqueId = widget.uniqueId ?? Random().nextInt(99999).toString();
    print('$tag => <initState> => Overlay Unique Id: $_uniqueId');

    _switchDelay = Duration(milliseconds: widget.animationDuration.inMilliseconds + 40);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (OverlayManager.instance.isOverlayCreated && !_focusNode.hasPrimaryFocus) {

          FocusScope.of(OverlayContainer.getOverlayContext).unfocus();
          print('$tag => <onTap> => Dropdown switching delayed...');
          Future.delayed(_switchDelay, _switchOverlay);
        } else {
          _switchOverlay();
        }
      },
      child: OverlayManager.instance.buildOverlay(
        focusNode: _focusNode,
        overlay: AnimatedOverlay(
          id: _uniqueId,
          height: widget.contentHeight,
          focusNode: _focusNode,
          dropdownContent: widget.dropdownContent,
          animationDuration: widget.animationDuration,
          closeOverlay: OverlayManager.instance.close,
        ),
        child: widget.dropdownHeader,
      ),
    );
  }

  void _switchOverlay() {
    print('$tag => <_switchOverlay> => Switching dropdown...');
    bool isOverlayCreated = OverlayManager.instance.isOverlayCreated;
    print('$tag => <_switchOverlay> => Has active overlays already? - $isOverlayCreated');

    if (isOverlayCreated) {
      _focusNode.unfocus();
      print('$tag => <_switchOverlay> => Closing overlay...');
    }

    if (!isOverlayCreated) {
      OverlayManager.instance.show(_uniqueId);
      _focusNode.requestFocus();
      print('$tag => <_switchOverlay> => Opening overlay...');
    }
  }
}
