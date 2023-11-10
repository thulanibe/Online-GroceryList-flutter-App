import 'package:flutter/material.dart';
import 'package:smartlist/widgets/palatte.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required MaterialColor buttonColor,
  });

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            Colors.green, // Change this line to set the button color to green
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Text(
            buttonText,
            style: kBodyText.copyWith(color: Colors.white), // Add this line
          ),
        ),
      ),
    );
  }
}
