import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:smartlist/screens/authentication_screens/reset_password.dart';
import 'package:smartlist/widgets/rounded_button.dart';
import 'package:smartlist/widgets/text_input.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _resetPasswordOnPressed(BuildContext context) async {
    final email = _emailController.text.trim();
    print('Attempting to reset password for email: $email');

    try {
      await Amplify.Auth.resetPassword(username: email);

      // Navigate to the PasswordResetConfirmationScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordResetConfirmationScreen(email: email),
        ),
      );
    } on AuthException catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            style: const TextStyle(fontSize: 16.0),
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password!",
          style: TextStyle(
            fontSize: 24, // Adjust the font size as needed
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double imageSize = constraints.maxHeight * 0.3;
              final double iconSize = constraints.maxWidth * 0.08;

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: constraints.maxHeight * 0.05),
                      child: SizedBox(
                        height: imageSize,
                        child: const Center(
                          child: Image(
                            image: AssetImage('assets/images/lock.png'),
                            height: 200, // Adjust image height as needed
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    TextInput(
                      icon: Icons.email,
                      hint: 'Enter email address',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        return null;
                      },
                      iconSize: iconSize,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    RoundedButton(
                      buttonText: 'Send',
                      buttonColor: Colors.green,
                      onPressed: () => _resetPasswordOnPressed(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
