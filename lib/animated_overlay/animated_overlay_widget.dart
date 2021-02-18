import 'package:flutter/material.dart';

class AnimatedOverlayWidget extends StatefulWidget {
  final double height;
  final FocusNode focusNode;
  final Widget dropdownContent;
  final VoidCallback closeOverlay;
  final Duration animationDuration;

  const AnimatedOverlayWidget({
    this.height,
    this.focusNode,
    this.closeOverlay,
    this.dropdownContent = const SizedBox(),
    this.animationDuration = const Duration(milliseconds: 300),
    Key key,
  }) : super(key: key);

  @override
  _AnimatedOverlayWidgetState createState() => _AnimatedOverlayWidgetState();
}

class _AnimatedOverlayWidgetState extends State<AnimatedOverlayWidget> with SingleTickerProviderStateMixin {
  static const String tag = '[Animated Overlay Widget]';
  Animation _tween;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print('$tag => <initState>');

    if (_tween != null) _tween.removeListener(() {});
    if (widget.focusNode != null) widget.focusNode.removeListener(() {});

    _controller = AnimationController(vsync: this, duration: widget.animationDuration);

    _tween = Tween<double>(begin: 0.0, end: widget.height).animate(_controller)..addListener(() => setState(() {}));

    if (widget.closeOverlay != null) {
      _tween..addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            widget.closeOverlay();
          }
        });
    }

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasPrimaryFocus) {
        if (mounted) {
          print('$tag => <initState> => Animation forward');
          _controller.forward();
        }
      }

      if (!widget.focusNode.hasPrimaryFocus) {
        if (mounted) {
          print('$tag => <initState> => Animation reverse');
          _controller.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    print('$tag => <dispose>');
    if (widget.focusNode != null && widget.focusNode.hasPrimaryFocus) {
      widget.focusNode.unfocus();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _tween.value,
      child: widget.dropdownContent,
    );
  }
}
