import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:poems_arabic/main.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> expandAnimation;
  bool open = false;

  @override
  void initState() {
    super.initState();
    open = widget.initialOpen ?? false;
    controller = AnimationController(
      value: open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: controller,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      open = !open;
      if (open) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomLeft,
        clipBehavior: Clip.none,
        children: [
          buildTapToCloseFab(),
          ...buildExpandingActionButtons(),
          buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget buildTapToCloseFab() {
    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Center(
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            child: InkWell(
              onTap: toggle,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 60.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          open ? 0.7 : 1.0,
          open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: FloatingActionButton(
              onPressed: toggle,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: primaryColor,
                size: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class ExpandingActionButton extends StatelessWidget {
  ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          // directionInDegrees * (math.pi / 360.0),
          directionInDegrees * (math.pi / 270),
          progress.value * maxDistance,
        );
        return Positioned(
          left: 10,
          bottom: 60 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.icon,
    this.tooltip,
    this.onPressed,
    this.text,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  final String? text;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      // elevation: 4.0,
      child: IconTheme.merge(
        data: theme.iconTheme,
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
