import 'package:flutter/material.dart';
import 'palatte.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
    this.suffix,
    this.obscure = false,
    required TextStyle style,
    required String? Function(dynamic value) validator,
    required double iconSize,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;
  final bool obscure;
  final Widget? suffix;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  Color borderColor = Colors.grey; // Initialize with default color
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        // Update the border color based on focus
        borderColor = focusNode.hasFocus ? Colors.transparent : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose(); // Dispose of the FocusNode when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor, // Use the borderColor variable
          ),
        ),
        child: TextFormField(
          focusNode: focusNode, // Assign the FocusNode to the TextFormField
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green, // Set focused border color to green
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            hintText: widget.hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Icon(
                widget.icon,
                color: Colors.green, // Set icon color to green
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
            suffixIcon: widget.suffix,
          ),
          obscureText: widget.obscure,
          style: kBodyText,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          controller: widget.controller,
        ),
      ),
    );
  }
}
