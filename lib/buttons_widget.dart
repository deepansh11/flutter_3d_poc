import 'package:flutter/material.dart';

class DPadControl extends StatelessWidget {
  const DPadControl({
    super.key,
    required this.onUpPress,
    required this.onDownPress,
    required this.onRightPress,
    required this.onLeftPress,
  });

  final VoidCallback onUpPress;

  final VoidCallback onDownPress;

  final VoidCallback onRightPress;

  final VoidCallback onLeftPress;

  @override
  Widget build(BuildContext context) {
    // Define common properties for the buttons
    const buttonSize = 60.0;
    const buttonColor = Colors.blue;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Up Button
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: IconButton(
            color: buttonColor,
            onPressed: onUpPress,
            icon: const Icon(Icons.keyboard_arrow_up),
            iconSize: buttonSize,
          ),
        ),
        // Left and Right Buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                color: buttonColor,
                onPressed: onLeftPress,
                icon: const Icon(Icons.keyboard_arrow_left),
                iconSize: buttonSize,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                color: buttonColor,
                onPressed: onRightPress,
                icon: const Icon(Icons.keyboard_arrow_right),
                iconSize: buttonSize,
              ),
            ),
          ],
        ),
        // Down Button
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: IconButton(
            color: buttonColor,
            onPressed: onDownPress,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: buttonSize,
          ),
        ),
      ],
    );
  }
}
