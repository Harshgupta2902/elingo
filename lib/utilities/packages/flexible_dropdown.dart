import 'package:flutter/material.dart';

class FlexibleDropdown extends StatefulWidget {
  final Widget child;
  final Widget overlayChild;
  final TextDirection textDirection;
  final AnimationType? animationType;
  final Alignment? animationAlignment;
  final Color? barrierColor;
  final BarrierShape? barrierShape;
  final Offset offset;
  final Duration? duration;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;
  final BorderRadius? borderRadius;
  final Duration? hoverDuration;
  final FlexibleDropdownController? controller;

  const FlexibleDropdown({
    Key? key,
    required this.child,
    required this.overlayChild,
    this.textDirection = TextDirection.rtl,
    this.offset = Offset.zero,
    this.animationType,
    this.animationAlignment,
    this.duration,
    this.barrierColor,
    this.barrierShape,
    this.onOpened,
    this.onClosed,
    this.borderRadius,
    this.hoverDuration,
    this.controller,
  }) : super(key: key);

  @override
  State<FlexibleDropdown> createState() => _FlexibleDropdownState();
}

class _FlexibleDropdownState extends State<FlexibleDropdown> {
  final FocusNode _flexibleFocusMode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.showDropdown = _showOverlayDialog;
      widget.controller!.hideDropdown = _hideOverlayDialog;
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _flexibleFocusMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        if (widget.controller != null) {
          widget.controller!.toggle();
        } else {
          _showOverlayDialog();
        }
      },
      canRequestFocus: true,
      focusNode: _flexibleFocusMode,
      highlightShape: BoxShape.rectangle,
      borderRadius: widget.borderRadius,
      child: widget.child,
    );
  }

  void _showOverlayDialog() {
    _flexibleFocusMode.requestFocus();
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final Offset offset = Offset(0.0, button.size.height) + widget.offset;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    widget.onOpened?.call();

    final NavigatorState navigator = Navigator.of(context, rootNavigator: false);
    navigator
        .push(
      FlexibleDropdownRoute(
        child: widget.overlayChild,
        position: position,
        textDirection: widget.textDirection,
        barrierShape: widget.barrierShape,
        barrierBgColor: widget.barrierColor,
        duration: widget.duration,
        animationType: widget.animationType ?? AnimationType.scale,
        animationAlignment: widget.animationAlignment ?? Alignment.topCenter,
      ),
    )
        .then((value) {
      if (!mounted) return;
      _flexibleFocusMode.unfocus();
      widget.onClosed?.call();
      if (widget.controller != null) {
        widget.controller!.isVisible = false;
      }
    });

    if (widget.controller != null) {
      widget.controller!.isVisible = true;
    }
  }

  void _hideOverlayDialog() {
    Navigator.of(context).pop();
    if (widget.controller != null) {
      widget.controller!.isVisible = false;
    }
  }
}

class FlexibleDropdownRoute<T> extends PopupRoute<T> {
  final Widget child;
  final RelativeRect position;
  final TextDirection textDirection;
  final Color? barrierBgColor;
  final BarrierShape? barrierShape;
  final Duration? duration;
  final AnimationType animationType;
  final Alignment animationAlignment;

  FlexibleDropdownRoute({
    required this.child,
    required this.position,
    this.barrierBgColor,
    this.barrierShape,
    this.duration,
    this.textDirection = TextDirection.rtl,
    required this.animationType,
    required this.animationAlignment,
  });

  @override
  Duration get transitionDuration => duration ?? const Duration(milliseconds: 350);
  @override
  Duration get reverseTransitionDuration => duration ?? const Duration(milliseconds: 350);
  @override
  Color? get barrierColor => null;
  @override
  bool get barrierDismissible => true;
  @override
  String? get barrierLabel => 'Flexible Dropdown';
  @override
  Widget buildModalBarrier() => ModalBarrierLayout(
        position: position,
        barrierColor: barrierBgColor,
        barrierShape: barrierShape,
      );
  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: false,
      removeBottom: false,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          final mediaQuery = MediaQuery.of(context);
          return CustomSingleChildLayout(
            delegate: OverlayRouteLayout(
              position,
              mediaQuery.padding,
              _avoidBounds(mediaQuery),
              textDirection,
            ),
            child: AnimatedBuilder(
              animation: animation,
              child: Material(
                color: Colors.transparent,
                child: child,
              ),
              builder: (context, child) {
                switch (animationType) {
                  case AnimationType.scale:
                    return ScaleTransition(
                      scale: animation,
                      alignment: animationAlignment,
                      child: child,
                    );
                  case AnimationType.scaleY:
                    return Transform.scale(
                      alignment: animationAlignment,
                      scaleY: animation.value,
                      child: child,
                    );
                  case AnimationType.scaleX:
                    return Transform.scale(
                      alignment: animationAlignment,
                      scaleX: animation.value,
                      child: child,
                    );
                  case AnimationType.size:
                    return SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: 0.0,
                      axis: Axis.vertical,
                      child: child,
                    );
                  case AnimationType.slide:
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  case AnimationType.rotate:
                    return RotationTransition(
                      turns: animation,
                      alignment: animationAlignment,
                      child: child,
                    );
                  case AnimationType.fade:
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  default:
                    return child ?? const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }

  Set<Rect> _avoidBounds(MediaQueryData mediaQuery) {
    return DisplayFeatureSubScreen.avoidBounds(mediaQuery).toSet();
  }
}

class ModalBarrierLayout extends StatelessWidget {
  final RelativeRect position;
  final Color? barrierColor;
  final BarrierShape? barrierShape;
  const ModalBarrierLayout({
    Key? key,
    required this.position,
    this.barrierColor,
    this.barrierShape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).pop();
      },
      onPanStart: (detail) {
        Navigator.of(context).pop();
      },
      child: _buildLayoutShape(),
    );
  }

  Widget _buildLayoutShape() {
    final Color bgColor = barrierColor ?? Colors.black38.withOpacity(.2);
    switch (barrierShape) {
      case BarrierShape.headerTrans:
        return CustomPaint(
          painter: HeaderTransPainter(position.top, bgColor),
          child: const SizedBox.expand(),
        );
      default: //normal
        return ColoredBox(
          color: bgColor,
          child: const SizedBox.expand(),
        );
    }
  }
}

class HeaderTransPainter extends CustomPainter {
  double topPosition;
  Color color;
  HeaderTransPainter(this.topPosition, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawRect(Rect.fromLTWH(0.0, topPosition, size.width, size.height), bgPaint);
  }

  @override
  bool shouldRepaint(HeaderTransPainter oldDelegate) {
    return topPosition != oldDelegate.topPosition;
  }
}

const double _kMenuScreenPadding = 0.0;

class OverlayRouteLayout extends SingleChildLayoutDelegate {
  OverlayRouteLayout(
    this.position,
    this.padding,
    this.avoidBounds,
    this.textDirection,
  );

  final RelativeRect position;
  final EdgeInsets padding;
  final Set<Rect> avoidBounds;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(_kMenuScreenPadding) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = position.top;
    double x;
    if (position.left > position.right) {
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      x = position.left;
    } else {
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }
    final Offset wantedPosition = Offset(x, y);
    final Offset originCenter = position.toRect(Offset.zero & size).center;
    final Iterable<Rect> subScreens =
        DisplayFeatureSubScreen.subScreensInBounds(Offset.zero & size, avoidBounds);
    final Rect subScreen = _closestScreen(subScreens, originCenter);
    return _fitInsideScreen(subScreen, childSize, wantedPosition);
  }

  Rect _closestScreen(Iterable<Rect> screens, Offset point) {
    Rect closest = screens.first;
    for (final Rect screen in screens) {
      if ((screen.center - point).distance < (closest.center - point).distance) {
        closest = screen;
      }
    }
    return closest;
  }

  Offset _fitInsideScreen(Rect screen, Size childSize, Offset wantedPosition) {
    double x = wantedPosition.dx;
    double y = wantedPosition.dy;
    if (x < screen.left + _kMenuScreenPadding + padding.left) {
      x = screen.left + _kMenuScreenPadding + padding.left;
    } else if (x + childSize.width > screen.right - _kMenuScreenPadding - padding.right) {
      x = screen.right - childSize.width - _kMenuScreenPadding - padding.right;
    }
    if (y < screen.top + _kMenuScreenPadding + padding.top) {
      y = _kMenuScreenPadding + padding.top;
    } else if (y + childSize.height > screen.bottom - _kMenuScreenPadding - padding.bottom) {
      y = screen.bottom - childSize.height - _kMenuScreenPadding - padding.bottom;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(OverlayRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

enum BarrierShape {
  normal,
  headerTrans,
}

enum AnimationType {
  scale,
  scaleY,
  scaleX,
  size,
  fade,
  slide,
  rotate,
}

class FlexibleDropdownController {
  VoidCallback? showDropdown;
  VoidCallback? hideDropdown;
  bool isVisible = false;

  void toggle() {
    if (isVisible) {
      hideDropdown?.call();
    } else {
      showDropdown?.call();
    }
    isVisible = !isVisible;
  }
}
