import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart' as om;

typedef Widget OverlayChildBuilder(BuildContext context);

class OverlayContainer extends StatefulWidget {
  OverlayContainer({
    @required this.overlay,
    @required this.builder,
    this.focusNode,
    Key key,
  }) : super(key: key);

  final FocusNode focusNode;
  final om.IOverlay overlay;
  final OverlayChildBuilder builder;

  static final GlobalKey _gl = GlobalKey();

  static BuildContext get getOverlayContext => _gl.currentContext;

  @override
  _OverlayContainerState createState() => _OverlayContainerState();
}

class _OverlayContainerState extends State<OverlayContainer> {
  OverlayEntry _overlayEntry;
  double initialOffset;
  final LayerLink _layerLink = LayerLink();
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _removeOverlayEntry();
    super.dispose();
  }

  void _removeOverlayEntry() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlayOnTopOfItem(BuildContext context) {
    final OverlayState overlayState = Overlay.of(context);

    final RenderBox renderBox = context.findRenderObject();
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          key: OverlayContainer._gl,
          width: size.width,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            link: _layerLink,
            offset: Offset(0, size.height),
            child: Focus(
              autofocus: true,
              focusNode: focusNode,
              child: Material(
                color: Colors.transparent,
                child: widget.overlay.widget,
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ValueListenableBuilder(
        valueListenable: om.OverlayManager.instance.getOverlayStateById(widget.overlay.id),
        builder: (BuildContext context, om.OverlayState state, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state == om.OverlayState.opened) {
              print('[Overlay Container] => <build> => _showOverlayOnTopOfItem()');
              _showOverlayOnTopOfItem(context);
            } else if (state == om.OverlayState.closed) {
              print('[Overlay Container] => <build> => _removeOverlayEntry()');
              _removeOverlayEntry();
            }
          });

          return widget.builder(context);
        },
      ),
    );
  }
}
