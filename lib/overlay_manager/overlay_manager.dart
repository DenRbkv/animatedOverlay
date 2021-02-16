import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_container.dart';

enum OverlayState { opened, closed }

class OverlayManager {
  static const tag = '[OverlayManager]';

  OverlayManager._privateConstructor();

  static final OverlayManager _instance = OverlayManager._privateConstructor();

  static OverlayManager get instance => _instance;

  Logger get _logger => Logger('$tag#');

  final List<Map<IOverlay, ValueNotifier<OverlayState>>> _overlayStates = [];

  bool get isOverlayCreated => _getCreatedOverlay != null;

  Map<IOverlay, ValueNotifier<OverlayState>> get _getCreatedOverlay {
    _logger.info('<_getCreatedOverlay> => Get Created Overlay');

    _logger.info('<_getCreatedOverlay> => _overlayStates.lng: ${_overlayStates.length}');

    for (Map<IOverlay, ValueNotifier<OverlayState>> overlayState in _overlayStates) {
      if (overlayState?.values?.first?.value == OverlayState.opened) {
        _logger.info('<_getCreatedOverlay> => Created overlay WAS found!');
        return overlayState;
      }
    }

    _logger.info('<_getCreatedOverlay> => Created overlay NOT found!');
    return null;
  }

  Widget buildOverlay({
    @required IOverlay overlay,
    @required Widget child,
    FocusNode focusNode,
  }) {
    _logger.info('<buildOverlay> => Build Overlay with id: ${overlay?.id}');
    if (getOverlayMapById(overlay.id) == null) {
      _logger.info('<buildOverlay> => Added New Overlay with id: ${overlay?.id}');

      _overlayStates.add({
        overlay: ValueNotifier<OverlayState>(OverlayState.closed),
      });
    }

    return OverlayContainer(
      overlay: overlay,
      focusNode: focusNode,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  void show(String id) {
    _logger.info('<show> => Show Overlay!');

    if (isOverlayCreated) return;

    final _overlay = getOverlayMapById(id);

    if (_overlay == null) return;

    _overlay.values.first.value = OverlayState.opened;
    _logger.info('<show> => Changed state of overlay with id: ${_overlay.keys.first?.id} to ${_overlay.values?.first?.value}');
  }

  void forceShow(String id) {
    _logger.info('<close> => Force Show!');

    if (isOverlayCreated) close();

    show(id);
  }

  void close() {
    _logger.info('<close> => Close!');

    _doCloseOverlay();
  }

  void _doCloseOverlay() {
    final _overlay = _getCreatedOverlay;

    if (_overlay == null) return;

    _overlay.values.first.value = OverlayState.closed;
    _logger.info('<show> => Changed state of overlay with id: ${_overlay.keys.first?.id} to ${_overlay.values?.first?.value}');
  }

  Map<IOverlay, ValueNotifier<OverlayState>> getOverlayMapById(String id) {
    if (_overlayStates == null || _overlayStates.isEmpty) {
      _logger.info('<getOverlayMapById> => _overlayStates.isEmpty!');
      return null;
    }

    final Map<IOverlay, ValueNotifier<OverlayState>> _overlay = _overlayStates?.firstWhere(
      (element) => id == element?.keys?.first?.id,
      orElse: () => null,
    );

    if (_overlay == null) {
      _logger.info('<getOverlayStateById> => _overlay not found!');
      return null;
    }

    return _overlay;
  }

  ValueNotifier<OverlayState> getOverlayStateById(String id) {
    if (_overlayStates == null || _overlayStates.isEmpty) {
      _logger.info('<getOverlayStateById> => _overlayStates.isEmpty!');
      return null;
    }

    final _overlay = getOverlayMapById(id);

    if (_overlay == null) {
      _logger.info('<getOverlayStateById> => _overlay not found!');
      return null;
    }

    return _overlay?.values?.first;
  }
}

abstract class IOverlay {
  final String id;

  IOverlay({
    @required this.id,
  });

  Widget get widget => const SizedBox();
}

class SearchOverlay implements IOverlay {
  @override
  final String id;

  SearchOverlay({
    @required this.id,
  });

  @override
  Widget get widget => Container(
        height: 400,
        width: 400,
        color: Colors.red,
      );
}
