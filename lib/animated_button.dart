import 'package:flutter/material.dart';

import 'main.dart';

class AnimatedFabButton extends StatefulWidget {
  final Function() onPressed;
  // final String tooltip;
  final IconData icon;
  const AnimatedFabButton(
      {super.key,
      required this.onPressed,
      // required this.tooltip,
      required this.icon});

  @override
  State<AnimatedFabButton> createState() => _AnimatedFabButtonState();
}

class _AnimatedFabButtonState extends State<AnimatedFabButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController animationController;
  late Animation<Color?> animateColor;
  late Animation<double> animateIcon;
  late Animation<double> translateButton;
  Curve curve = Curves.easeOut;
  double fabHeight = 56;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
          microseconds: 500,
        ))
      ..addListener(() {
        setState(() {});
      });
    animateIcon =
        Tween<double>(begin: 0, end: 0.1).animate(animationController);
    animateColor = ColorTween(begin: Colors.white, end: Colors.white).animate(
      CurvedAnimation(
          parent: animationController,
          curve: Interval(
            0,
            1,
            curve: Curves.linear,
          )),
    );
    translateButton = Tween<double>(begin: fabHeight, end: -14).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0,
          0.75,
          curve: curve,
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget save() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(
          Icons.save_outlined,
          color: primaryColor,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget addImage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(
          Icons.image_outlined,
          color: primaryColor,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget share() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(
          Icons.share,
          color: primaryColor,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget toggle() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {
          animate();
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          color: primaryColor,
          size: 26,
          progress: animateIcon,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value * 3,
            0.0,
          ),
          child: save(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value * 2,
            0.0,
          ),
          child: addImage(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value,
            0.0,
          ),
          child: share(),
        ),
        toggle(),
      ],
    );
  }
}
