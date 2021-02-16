import 'package:flutter/material.dart';

class AnimatedOverlayWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Widget dropdownContent;
  final VoidCallback closeOverlay;

  const AnimatedOverlayWidget({Key key, this.focusNode, this.closeOverlay, this.dropdownContent}) : super(key: key);

  @override
  _AnimatedOverlayWidgetState createState() => _AnimatedOverlayWidgetState();
}

class _AnimatedOverlayWidgetState extends State<AnimatedOverlayWidget> with SingleTickerProviderStateMixin {
  Animation _tween;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (_tween != null) _tween.removeListener(() {});
    if (widget.focusNode != null) widget.focusNode.removeListener(() {});

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _tween = Tween<double>(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    if (widget.closeOverlay != null) {
      _tween
        ..addStatusListener((status) {
          if (status == AnimationStatus.dismissed) widget.closeOverlay();
        });
    }

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasPrimaryFocus) if (mounted) _controller.forward();
      if (!widget.focusNode.hasPrimaryFocus) if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    widget.focusNode.unfocus();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _tween.value,
      child: widget.dropdownContent ?? const SizedBox(),
    );
  }
}
